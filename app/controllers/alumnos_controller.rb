class AlumnosController < ApplicationController

  def index  
    @alumnosData = Alumno.using(:data_warehouse).all
    export
  end

  def edit
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @errores = [@alumno.errorNombre, @alumno.errorTelefono, @alumno.errorCurp, @alumno.errorPeso]
  end

  def update
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @errores = [@alumno.errorNombre, @alumno.errorTelefono, @alumno.errorCurp, @alumno.errorPeso]
    if @alumno.update_attributes({Id_Alumno: params[:alumno][:Id_Alumno], Nombre: params[:alumno][:Nombre], Telefono: params[:alumno][:Telefono], Curp: params[:alumno][:Curp], Peso: params[:alumno][:Peso], errorNombre: nil, errorTelefono: nil, errorCurp: nil, errorPeso: nil})
      redirect_to "/" 
    else
      render :edit
    end
  end

  def destroy
    @alumno = Alumno.using(:data_warehouse).find_by(Id_Alumno: params[:id])
    @alumno.destroy
    redirect_to "/", notice: "Registro borrado con éxito"
  end

  private

  def export
    Alumno.using(:data_warehouse).delete_all if !Alumno.using(:data_warehouse).all.empty?
    
    id_al=0
    @excel = @biblio.sheet('Alumnos')
    @alumnosCA = Alumno.using(:controlA).all 
    @alumnosE= Alumno.using(:extra).all 

    @alumnosCA.each do |alumnoCA|
      alumnoNew = Alumno.using(:data_warehouse).new
      if validate_name(alumnoCA.Nombre)
        alumnoNew.errorNombre = 1
      end
      if !validate_number(alumnoCA.Telefono)
        alumnoNew.errorTelefono = 1
      end
      if !validate_curp(alumnoCA.Curp)
        alumnoNew.errorCurp = 1
      end
      id_al+=1
      alumnoNew.Id_Alumno = id_al
      alumnoNew.No_control = alumnoCA.No_control
      alumnoNew.Id_Carrera = alumnoCA.Id_Carrera
      alumnoNew.Nombre = alumnoCA.Nombre
      alumnoNew.Genero = alumnoCA.Genero
      alumnoNew.CorreoElec = alumnoCA.CorreoElec
      alumnoNew.Dirección = alumnoCA.Dirección
      alumnoNew.Telefono = alumnoCA.Telefono
      alumnoNew.Curp = alumnoCA.Curp
      alumnoNew.Fecha_nac = alumnoCA.Fecha_nac
      alumnoNew.Cre_acum = alumnoCA.Cre_acum
      alumnoNew.Promedio_G = alumnoCA.Promedio_G 
      alumnoNew.Estado = alumnoCA.Estado
      alumnoNew.Fec_ingreso = alumnoCA.Fecha_ing 
      alumnoNew.Fec_egreso = alumnoCA.Fec_egreso
      @alumnosE.each do |alumnoE| #Si el alumno existe en Extraescolares, agregar el peso y la estatura registrada
        if alumnoCA.No_control == alumnoE.No_control
          alumnoNew.Peso = alumnoE.Peso
          alumnoNew.Estatura = alumnoE.Estatura
        end
      end
      alumnoNew.save!     
    end


    @alumnosE.each do |alumnoE| #Ingresar los que no existen en Control Academico
      if @alumnosCA.exists?(No_control: alumnoE.No_control) == false    
        alumnoNew = Alumno.using(:data_warehouse).new
        if validate_name(alumnoE.Nombre)
          alumnoNew.errorNombre = 1
        end
        if !validate_number(alumnoE.Telefono)
          alumnoNew.errorTelefono = 1
        end
        if !validate_weight(alumnoE.Peso)
          alumnoNew.errorPeso = 1
        end
        id_al += 1
        alumnoNew.Id_Alumno = id_al
        alumnoNew.No_control = alumnoE.No_control
        alumnoNew.Id_Carrera = alumnoE.Carrera
        alumnoNew.Nombre = alumnoE.Nombre
        alumnoNew.Genero = alumnoE.Genero
        alumnoNew.CorreoElec = alumnoE.Email
        alumnoNew.Telefono = alumnoE.Telefono
        alumnoNew.Fecha_nac = alumnoE.Fecha_nacimineto
        alumnoNew.Fec_ingreso = alumnoE.Fecha_ingreso 
        alumnoNew.Peso = alumnoE.Peso
        alumnoNew.Estatura = alumnoE.Estatura
        alumnoNew.save!     
      end
    end
  end

end
