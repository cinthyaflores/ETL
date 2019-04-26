class BajasController < ApplicationController
  def index
    @bajas_data = Baja.using(:data_warehouse).all
    export
  end

  private

  def export
    Baja.using(:data_warehouse).delete_all if !Baja.using(:data_warehouse).all.empty?

    @bajas_ca = Baja.using(:controlA).all

    @bajas_ca.each do |baja|
      @baja_new = Baja.using(:data_warehouse).new
      @baja_new.Id_Baja = baja.Id_Baja
      @baja_new.Id_Alumno = baja.Id_Alumno
      @baja_new.Id_Tipo_Baja = baja.Id_Tipo_Baja
      @baja_new.Fecha_Baja = baja.Fecha_Baja
      @baja_new.save!
    end
  end
end
