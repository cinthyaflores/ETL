class DetalleOrdenCompraController < ApplicationController
  def index
    @orden_data = Detalle_orden_compra.using(:data_warehouse).all
    export
  end

  private

    def export
      Detalle_orden_compra.using(:data_warehouse).delete_all if !Detalle_orden_compra.using(:data_warehouse).all.empty?

      @orden_extra = Detalle_orden_compra.using(:extra).all

      @orden_extra.each do |orden|
        orden_new = Detalle_orden_compra.using(:data_warehouse).new
        orden_new.Id_orden_compra = orden.Id_orden_compra
        orden_new.Id_recurso = orden.IdRM
        orden_new.Cantidad = orden.Cantidad
        orden_new.Costo_unitario = orden.Costo_unitario
        orden_new.save!
      end
    end
end
