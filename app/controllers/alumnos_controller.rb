# frozen_string_literal: true

class AlumnosController < ApplicationController
  def init
    export
  end

  def index
    @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
    verify
  end

  def edit
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @errores = [@alumno.errorNombre, @alumno.errorTelefono, @alumno.errorCurp, @alumno.errorPeso]
  end

  def update
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @errores = [@alumno.errorNombre, @alumno.errorTelefono, @alumno.errorCurp, @alumno.errorPeso]
    case @alumno.base
    when "c"
      update = @alumno.update_attributes(Id_Alumno: params[:alumno][:Id_Alumno], Nombre: params[:alumno][:Nombre], Telefono: params[:alumno][:Telefono], Curp: params[:alumno][:Curp], Peso: params[:alumno][:Peso], errorNombre: nil, errorTelefono: nil, errorCurp: nil)
    when "ce"
      update = @alumno.update_attributes(Id_Alumno: params[:alumno][:Id_Alumno], Nombre: params[:alumno][:Nombre], Telefono: params[:alumno][:Telefono], Curp: params[:alumno][:Curp], Peso: params[:alumno][:Peso], telefono_extra: params[:alumno][:telefono_extra], errorNombre: nil, errorTelefono: nil, errorCurp: nil, errorPeso: nil)
    when "e"
      update = @alumno.update_attributes(Id_Alumno: params[:alumno][:Id_Alumno], Nombre: params[:alumno][:Nombre], Curp: params[:alumno][:Curp], Peso: params[:alumno][:Peso], telefono_extra: params[:alumno][:telefono_extra], errorNombre: nil, errorTelefono: nil, errorCurp: nil, errorPeso: nil)
    end
    if update
      redirect_to "/alumnos"
    else
      render :edit
    end
  end

  def destroy
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @alumno.destroy
    redirect_to "/alumnos", notice: "Registro borrado con éxito"
  end

  def delete_table
    Alumno.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Alumno.using(:data_warehouse).where(errorNombre: 2).destroy_all
    Alumno.using(:data_warehouse).where(errorTelefono: 1).destroy_all
    Alumno.using(:data_warehouse).where(errorTelefono: 2).destroy_all
    Alumno.using(:data_warehouse).where(errorCurp: 1).destroy_all
    Alumno.using(:data_warehouse).where(errorCurp: 2).destroy_all
    Alumno.using(:data_warehouse).where(errorPeso: 1).destroy_all
    Alumno.using(:data_warehouse).where(errorPeso: 2).destroy_all
    
    redirect_to "/alumnos"
  end
  

  private

    def verify
      case current_user.tipo
      when 1
        @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
        @alumnosData.each do |alumno|
          if alumno.errorNombre || alumno.errorPeso || alumno.errorTelefono || alumno.errorCurp
            @errores = true
          end
        end
      when 2 #ERRORES EN CONTROL ACADEMICO
        @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
        @alumnosData.each do |alumno|
          if alumno.errorNombre == 1 || alumno.errorTelefono == 1 || alumno.errorCurp == 1
            @errores = true
          end
        end
      when 3 #ERRORES EN EXTRAESCOLARE
        @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
        @alumnosData.each do |alumno|
          if alumno.errorNombre == 2|| alumno.errorPeso == 2 || alumno.errorTelefono == 2
            @errores = true
          end
        end
      end
    end

    def export
      Alumno.using(:data_warehouse).delete_all if !Alumno.using(:data_warehouse).all.empty?

      id_al = 0
      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @alumnosBi = @biblio.sheet("Alumnos")
      @alumnosCA = Alumno.using(:controlA).all
      @alumnosE = Alumno.using(:extra).all

      @alumnosCA.each do |alumnoCA|
        alumnoNew = Alumno.using(:data_warehouse).new
        if validate_name(alumnoCA.Nombre)
          alumnoNew.errorNombre = 1
        end
        if !validate_number(alumnoCA.Telefono)
          alumnoNew.errorTelefono = 1 # Error 1 es en Control Academico
        end
        if !validate_curp(alumnoCA.Curp)
          alumnoNew.errorCurp = 1
        end
        id_al += 1
        alumnoNew.Id_Alumno = id_al
        alumnoNew.No_control = alumnoCA.No_control
        alumnoNew.Id_Carrera = alumnoCA.Id_Carrera
        alumnoNew.Nombre = alumnoCA.Nombre
        alumnoNew.Genero = alumnoCA.Genero
        alumnoNew.CorreoElec = alumnoCA.CorreoElec
        alumnoNew.Dirección = alumnoCA.Dirección
        alumnoNew.Telefono = alumnoCA.Telefono # GUARDO LOS 2 NUMEROS
        alumnoNew.Curp = alumnoCA.Curp
        alumnoNew.Fecha_nac = alumnoCA.Fecha_nac
        alumnoNew.Cre_acum = alumnoCA.Cre_acum
        alumnoNew.Promedio_G = alumnoCA.Promedio_G
        alumnoNew.Estado = alumnoCA.Estado
        alumnoNew.Fec_ingreso = alumnoCA.Fecha_ing
        alumnoNew.Fec_egreso = alumnoCA.Fec_egreso
        alumnoNew.base = "c"
        @alumnosE.each do |alumnoE| # Si el alumno existe en Extraescolares, agregar el peso y la estatura registrada
          if alumnoCA.No_control == alumnoE.No_control
            if !validate_number(alumnoE.Telefono)
              alumnoNew.errorTelefono = 2
              @error=true
            end
            if !validate_weight(alumnoE.Peso)
              alumnoNew.errorPeso = 2
            end
            alumnoNew.Peso = alumnoE.Peso
            alumnoNew.Estatura = alumnoE.Estatura
            alumnoNew.telefono_extra = alumnoE.Telefono # GUARDO LOS 2 NUMEROS
            alumnoNew.base = "ce"
          end
        end
        alumnoNew.save!
      end


      @alumnosE.each do |alumnoE| # Ingresar los que no existen en Control Academico
        if @alumnosCA.exists?(No_control: alumnoE.No_control) == false
          alumnoNew = Alumno.using(:data_warehouse).new
          if validate_name(alumnoE.Nombre)
            alumnoNew.errorNombre = 2
          end
          if !validate_number(alumnoE.Telefono)
            alumnoNew.errorTelefono = 2 # Error 2 es en la base de extraescolares
          end
          if !validate_weight(alumnoE.Peso)
            alumnoNew.errorPeso = 2
          end
          id_al += 1
          alumnoNew.Id_Alumno = id_al
          alumnoNew.No_control = alumnoE.No_control
          alumnoNew.Id_Carrera = alumnoE.Carrera
          alumnoNew.Nombre = alumnoE.Nombre
          alumnoNew.Genero = alumnoE.Genero
          alumnoNew.CorreoElec = alumnoE.Email
          alumnoNew.telefono_extra = alumnoE.Telefono
          alumnoNew.Fecha_nac = alumnoE.Fecha_nacimineto
          alumnoNew.Fec_ingreso = alumnoE.Fecha_ingreso
          alumnoNew.Peso = alumnoE.Peso
          alumnoNew.Estatura = alumnoE.Estatura
          alumnoNew.base = "e"
          alumnoNew.save!
        end
      end

      @alumnosBi.each_row_streaming(offset: 1) do |alumnoB| # Ingresar los que no existen en Control Academico
        if @alumnosCA.exists?(No_control: alumnoB[1].value) == false
          alumnoNew = Alumno.using(:data_warehouse).new
          id_al += 1
          alumnoNew.Id_Alumno = alumnoB[0]
          alumnoNew.No_control = alumnoB[1]
          alumnoNew.Id_Carrera = alumnoB[2]
          alumnoNew.base = "b"
          alumnoNew.save!
        end
      end
    end
end
