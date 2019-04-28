class OrdenDeCompraController < ApplicationController
  def init
    export
  end

  def index
    @ordenes_data = Orden_de_compra.using(:data_warehouse).all
    export
  end

  private

    def export
      Orden_de_compra.using(:data_warehouse).delete_all if !Orden_de_compra.using(:data_warehouse).all.empty?

      @ordenes_extra = Orden_de_compra.using(:extra).all 

      @ordenes_extra.each do |orden|
        orden_new = Orden_de_compra.using(:data_warehouse).new
        orden_new.Id_orden_compra = orden.Id_orden_compra
        orden_new.Fecha = orden.Fecha
        orden_new.Costo = orden.Costo
        orden_new.Estado = orden.Estado
        orden_new.save!
      end
    end
end
