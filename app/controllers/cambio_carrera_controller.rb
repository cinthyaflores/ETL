class CambioCarreraController < ApplicationController
  def index
    @cambios_data = Cambio_carrera.using(:data_warehouse).all
    export
  end

  private

  def export
    Cambio_carrera.using(:data_warehouse).delete_all if !Cambio_carrera.using(:data_warehouse).all.empty?

    @cambios_ca = Cambio_carrera.using(:controlA).all

    @cambios_ca.each do |cambio|
      @cambio_new = Cambio_carrera.using(:data_warehouse).new
      @cambio_new.Id_Cambio = cambio.Id_Cambio
      @cambio_new.Id_Alumno = cambio.Id_Alumno
      @cambio_new.Id_Carr_Ant = cambio.Id_Carr_Ant
      @cambio_new.Fec_Cambio = cambio.Fec_Cambio
      @cambio_new.save!
    end
  end
end
