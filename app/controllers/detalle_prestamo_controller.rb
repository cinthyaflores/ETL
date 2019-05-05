class DetallePrestamoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Detalle_prestamo.using(:data_warehouse).all.empty?
  end

  def index
    @prestamo_data = Detalle_prestamo.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Detalle_prestamo.using(:data_warehouse_final).delete_all if !Detalle_prestamo.using(:data_warehouse_final).all.empty?

    detalle = Detalle_prestamo.using(:data_warehouse).all
    detalle.each do |data|
      Detalle_prestamo.using(:data_warehouse_final).create(
        Id_prestamo: data.Id_prestamo, IdRM: data.IdRM, 
        Cantidad: data.Cantidad)
    end
  end
  
  def data 
    niveles = Detalle_prestamo.using(:data_warehouse).all
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
