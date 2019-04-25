class MaestrosController < ApplicationController
  def index
   #@excel = @biblio.sheet('maestro')
    @maestrosCA = Maestro.using(:controlA).all #CAMPOS: Id_Maestro, Id_Area_mtro, Id_contrato, Nombre, CorreoElec, Telefono, Titulo
    @maestrosE= Maestro.using(:extra).all #CAMPOS: Id_Maestro, Nombre, Genero, Edad, Fecha_Nacimiento, Telefono, Correo, TipoMaestro

    @nameErrorsCA = Array.new 
    @numberErrorsCA = Array.new 
    @bothErrorsCA = Array.new

    @maestrosCA.each do |maestro|
      if validate_name(maestro.Nombre) && !validate_number(maestro.Telefono)
        @bothErrorsCA << maestro
      elsif validate_name(maestro.Nombre)
        @nameErrorsCA << maestro
      elsif !validate_number(maestro.Telefono)
        @numberErrorsCA << maestro
      end
    end

    @nameErrorsE = Array.new 
    @numberErrorsE = Array.new 
    @bothErrorsE = Array.new 
    
    @maestrosE.each do |maestro|
      if validate_name(maestro.Nombre) && !validate_number(maestro.Telefono)
        @bothErrorsE << maestro
      elsif validate_name(maestro.Nombre)
        @nameErrorsE << maestro
      elsif !validate_number(maestro.Telefono)
        @numberErrorsE << maestro
      end
    end

    @nameErrorsB = Array.new #Errores en Biblioteca

    # @excel.each(noctrol: 'No. Control', name: 'Nombre', gen: 'Género', email: 'E-mail') do |hash|
    #   if validate_name( hash[:name] )
    #     @nameErrorsB << hash
    #   end
    # end

  end

  def edit
  end

  def update
  end

  def delete
  end
end
