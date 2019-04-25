class CarreraController < ApplicationController
  def index
    #@excelB
    @carrerasCA = Carrera.using(:controlA).all #Id_carrera, Nombre, Descripción, Creditos, Acreditada
    @carrerasE = Carrera.using(:extra).all #CAMPOS: Id_carrera, Nombre

    @nameErrorsE = Array.new #ERRORES EN CARRERA

    @carrerasE.each do |carrera|
      if validate_name(carrera.Nombre)
        @nameErrorsE << carrera
      end
    end

  end
end
