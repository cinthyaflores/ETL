class DetallePrestamoController < ApplicationController
  def index
    @prestamo_data = Detalle_prestamo.using(:data_warehouse).all
    export
  end

  private

    def export
      Detalle_prestamo.using(:data_warehouse).delete_all if !Detalle_prestamo.using(:data_warehouse).all.empty?

      @prestamo_extra = Detalle_prestamo.using(:extra).all

      @prestamo_extra.each do |prestamo|
        prestamo_new = Detalle_prestamo.using(:data_warehouse).new
        prestamo_new.Id_prestamo = prestamo.Id_prestamo
        prestamo_new.IdRM = prestamo.IdRM
        prestamo_new.Cantidad = prestamo.Cantidad
        prestamo_new.save!
      end
    end
end
