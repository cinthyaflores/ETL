# frozen_string_literal: true

class AlumnosController < ApplicationController
  require 'axlsx'

  def init
    export
  end

  def empty
    return Alumno.using(:data_warehouse).all.empty?
  end

  def index
    @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
  end

  def edit
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @errores = [@alumno.errorNombre, @alumno.errorTelefono, @alumno.errorCurp, @alumno.errorPeso, @alumno.errorCorreo, @alumno.errorPromedio, @alumno.errorCreditos]
  end

  def update
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @errores = [@alumno.errorNombre, @alumno.errorTelefono, @alumno.errorCurp, @alumno.errorPeso, @alumno.errorCorreo, @alumno.errorPromedio, @alumno.errorCreditos]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campos_modificados = Array.new
    case current_user.tipo
    when 1
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Nombre") if @errores[0] != nil
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Teléfono") if @errores[1] != nil
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Curp") if @errores[2] != nil
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Peso") if @errores[3] != nil
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Correo") if @errores[4] != nil
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Promedio") if @errores[5] != nil
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Créditos") if @errores[6] != nil
    when 2
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Nombre") if @errores[0] == 1
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Teléfono") if @errores[1]  == 1
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Curp") if @errores[2] == 1
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Correo") if @errores[4] == 1
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Promedio") if @errores[5] == 1
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Créditos") if @errores[6] == 1
    when 3
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Nombre") if @errores[0] == 2
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Teléfono") if @errores[1] == 2
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Peso") if @errores[3] == 2
      campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Correo") if @errores[4] == 2
    end
   
    case @alumno.base
    when "c"
      update = @alumno.update_attributes(Nombre: params[:alumno][:Nombre], Telefono: params[:alumno][:Telefono], Curp: params[:alumno][:Curp], Cre_acum: params[:alumno][:Cre_acum], CorreoElec: params[:alumno][:CorreoElec], Promedio_G: params[:alumno][:Promedio_G], errorNombre: nil, errorTelefono: nil, errorCurp: nil, errorCorreo: nil, errorPromedio: nil, errorCreditos: nil)
    when "ce"
      update = @alumno.update_attributes(Nombre: params[:alumno][:Nombre], Telefono: params[:alumno][:Telefono], Curp: params[:alumno][:Curp], Peso: params[:alumno][:Peso], Cre_acum: params[:alumno][:Cre_acum], CorreoElec: params[:alumno][:CorreoElec], Promedio_G: params[:alumno][:Promedio_G], telefono_extra: params[:alumno][:telefono_extra], errorNombre: nil, errorTelefono: nil, errorCurp: nil, errorPeso: nil, errorCorreo: nil, errorPromedio: nil, errorCreditos: nil)
    when "e"
      update = @alumno.update_attributes(Nombre: params[:alumno][:Nombre], telefono_extra: params[:alumno][:telefono_extra], Peso: params[:alumno][:Peso], CorreoElec: params[:alumno][:CorreoElec], errorNombre: nil, errorTelefono: nil, errorPeso: nil, errorCorreo: nil)
    end

    if update
      User_logins.using(:data_warehouse).all
      campos_modificados.each do |campo|
        User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)
      end
      redirect_to "/alumnos"
    else
      render :edit
    end

  end

  def destroy
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @alumno.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Alumno ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/alumnos"
  end

  def delete_table
    case current_user.tipo
    when 1
      Alumno.using(:data_warehouse).where(errorNombre: [1,2]).destroy_all
      Alumno.using(:data_warehouse).where(errorTelefono: [1,2,3]).destroy_all
      Alumno.using(:data_warehouse).where(errorCurp: [1,2]).destroy_all
      Alumno.using(:data_warehouse).where(errorPeso: [1,2]).destroy_all
      Alumno.using(:data_warehouse).where(errorCorreo: [1,2]).destroy_all
      Alumno.using(:data_warehouse).where(errorCreditos: [1,2]).destroy_all
      Alumno.using(:data_warehouse).where(errorPromedio: [1,2]).destroy_all
      campo_modificado = "Eliminó todos los registros de todas las bases - Alumno"
    when 2
      Alumno.using(:data_warehouse).where(errorNombre: [1]).destroy_all
      Alumno.using(:data_warehouse).where(errorTelefono: [1,3]).destroy_all
      Alumno.using(:data_warehouse).where(errorCurp: [1]).destroy_all
      Alumno.using(:data_warehouse).where(errorCorreo: [1]).destroy_all
      Alumno.using(:data_warehouse).where(errorCreditos: [1]).destroy_all
      Alumno.using(:data_warehouse).where(errorPromedio: [1]).destroy_all
      campo_modificado = "Eliminó todos los registros de Control Academico - Alumno"
    when 3
      Alumno.using(:data_warehouse).where(errorNombre: [2]).destroy_all
      Alumno.using(:data_warehouse).where(errorTelefono: [2,3]).destroy_all
      Alumno.using(:data_warehouse).where(errorPeso: [2]).destroy_all
      Alumno.using(:data_warehouse).where(errorCorreo: [2]).destroy_all
      campo_modificado = "Eliminó todos los registros de Extraescolares - Alumno"
    end
    
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado) 
    redirect_to "/show_tables"
  end

  def verify(c_user)
    case c_user 
    when 1
      @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
      @alumnosData.each do |alumno|
        if alumno.errorNombre || alumno.errorPeso || alumno.errorTelefono || alumno.errorCurp || alumno.errorCorreo || alumno.errorPromedio || alumno.errorCreditos
          return true
        end
      end
    when 2 #ERRORES EN CONTROL ACADEMICO
      @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
      @alumnosData.each do |alumno|
        if alumno.errorNombre == 1 || alumno.errorTelefono == 1  || alumno.errorCurp == 1  || alumno.errorCorreo == 1  || alumno.errorPromedio == 1  || alumno.errorCreditos == 1 
          return true
        end
      end
    when 3 #ERRORES EN EXTRAESCOLARE
      @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
      @alumnosData.each do |alumno|
        if alumno.errorNombre == 2 || alumno.errorPeso == 2 || alumno.errorTelefono == 2 || alumno.errorCorreo == 2 
          return true
        end
      end
    end
    
    return false
  end

  def export_to_sql
    
    alumnos_bien = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
    Alumno.using(:data_warehouse).new
    alumnos_bien.each do |data|
      Alumno.using(:data_warehouse_final).create(Id_Alumno: data.Id_Alumno, No_control: data.No_control, Id_Carrera: data.Id_Carrera, Nombre: data.Nombre, Genero: data.Genero, CorreoElec: data.CorreoElec, Telefono: data.Telefono, Curp: data.Curp, Fecha_nac: data.Fecha_nac, Cre_acum: data.Cre_acum, Promedio_G: data.Promedio_G, Estado: data.Estado, Fec_ingreso: data.Fec_ingreso, Fec_egreso: data.Fec_egreso, Peso: data.Peso, Estatura: data.Estatura, telefono_extra: data.telefono_extra)
    end
  end
  
  def data 
    Alumno.using(:data_warehouse).all.order(:Id_Alumno)
  end

  private

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
        if !validate_email(alumnoCA.CorreoElec)
          alumnoNew.errorCorreo = 1 # Error 1 es en Control Academico
        end
        if !validate_weight(alumnoCA.Promedio_G)
          alumnoNew.errorPromedio = 1
        end
        if !validate_weight(alumnoCA.Cre_acum)
          alumnoNew.errorCreditos = 1 # Error 1 es en Control Academico
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
          #VALIDAR TAMBIEN LOS DATOS DE CORREO Y DE FECHAS? Se van a sobreescribir y ocuparía hacer algo como lo de telefono
          if alumnoCA.No_control == alumnoE.No_control
            if !validate_number(alumnoE.Telefono)
              if alumnoNew.errorTelefono == 1
                alumnoNew.errorTelefono = 3
              else
                alumnoNew.errorTelefono = 2
              end
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
          if !validate_email(alumnoE.Email)
            alumnoNew.errorCorreo = 2 
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

      @alumnosData = Alumno.using(:data_warehouse).all.order(:Id_Alumno)
      @alumnosBi.each_row_streaming(offset: 1) do |alumnoB| # Ingresar los que no existen en Control Academico
        if @alumnosData.exists?(No_control: alumnoB[1].value) == false
          alumnoNew = Alumno.using(:data_warehouse).new
          id_al += 1
          alumnoNew.Id_Alumno = id_al
          alumnoNew.No_control = alumnoB[1]
          alumnoNew.Id_Carrera = alumnoB[2].value
          alumnoNew.base = "b"
          alumnoNew.save!
        end
      end
    end
end
