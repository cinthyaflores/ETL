class AlumnosController < ApplicationController
  def index  
    @excel = @biblio.sheet('alumnos')
    @alumnosCA = Alumno.using(:controlA).all #CAMPOS: Id_Alumno, No_control, Id_Carrera, Id_curso, Nombre, Genero, CorreoElec, Dirección, Telefono, Curp, Fecha_nac, Fecha_ing, Cre_acum, Promedio_G, Estado, Fec_egreso
    @alumnosE= Alumno.using(:extra).all #CAMPOS: No_control, Nombre, Genero, Email, Edad, Fecha_nacimineto, Fecha_ingreso, Peso, Estatura, Telefono, Carrera, Numero_emergencia, TipoAlumno

    @exists = Array.new #Alumnos de Extraescolares en Control Academico
    collect_data()

    @nameErrorsCA = Array.new #Errores en Control academico 
    @numberErrorsCA = Array.new #Errores en el Telefono 
    @curpErrorsCA = Array.new #Errores en el Telefono 

    @alumnosCA.each do |alumno|
      if validate_name(alumno.Nombre)
        @nameErrorsCA << alumno
      end
      if !validate_number(alumno.Telefono)
        @numberErrorsCA << alumno
      end
      if !validate_curp(alumno.Curp)
        @curpErrorsCA << alumno
      end
    end

    @weightErrorsE = Array.new #Errores en Extraescolares
    @numberErrorsE = Array.new #Errores en Telefono
    @bothErrorsE = Array.new #Errores en Ambos

    @alumnosE.each do |alumno|
      if !validate_weight(alumno.Peso) && !validate_number(alumno.Telefono)
        @bothErrorsE << alumno
      elsif !validate_weight(alumno.Peso)
        @weightErrorsE << alumno
      elsif !validate_number(alumno.Telefono)
        @numberErrorsE << alumno
      end
    end

    @nameErrorsB = Array.new #Errores en Biblioteca
    @excel.each(noctrol: 'No. Control', name: 'Nombre', gen: 'Género', email: 'E-mail') do |hash|
      if validate_name( hash[:name] )
        @nameErrorsB << hash
      end
    end
  end

  def edit
    #@alumno = Alumno.using(:controlA).find(params[:id])
  end

  def update
  end

  def delete
  end

  private

  def collect_data()
    #Alumnos de BIBLIOTECA que existen en Control Academico
    @excel.each(noctrol: 'No. Control') do |hash|
      @alumnosCA.each do |alumno|
        if hash[:noctrol] == alumno.No_control
          @exists << alumno
        end 
      end
    end
    #Alumnos de EXTRAESCOLARES que existen en Control Academico
    @alumnosE.each do |alumnoE|
      @alumnosCA.each do |alumnoCA|
        if alumnoE.No_control == alumnoCA.No_control
          @exists << alumnoCA
        end
      end
    end
  end

  def export
    alumnosData = Alumno.using(:Data)
    aluControl = Alumno.using(:controlA).all
    
    aluControl.each do |alumno|
      #alumnosData.No_control = alumno.No_Control
      #etc
      #alumnosData.save
    end
    
  end
end
