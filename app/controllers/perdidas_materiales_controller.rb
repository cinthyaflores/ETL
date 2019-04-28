class PerdidasMaterialesController < ApplicationController
  def init
    export
  end

  def index
    @perdidas_data = Perdidas_materiales.using(:data_warehouse).all
    export
  end

  private

    def export
      Perdidas_materiales.using(:data_warehouse).delete_all if !Perdidas_materiales.using(:data_warehouse).all.empty?

      @perdidas_extra = Perdidas_materiales.using(:extra).all 

      @perdidas_extra.each do |perdida|
        perdida_new = Perdidas_materiales.using(:data_warehouse).new
        perdida_new.Id_perdida = perdida.Id_perdida
        perdida_new.Id_recurso = perdida.IdRM
        perdida_new.Id_prestamo = perdida.Id_prestamo
        perdida_new.Cantidad = perdida.Cantidad
        perdida_new.Costo_total = perdida.Costo_total
        perdida_new.save!
      end
    end
end
