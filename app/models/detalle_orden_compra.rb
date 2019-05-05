class Detalle_orden_compra < ApplicationRecord
  self.table_name = "Detalle_orden_compra"

  validates :Cantidad, format: { with:  /\A\d+/, message: "La cantidad debe ser un valor númerico positivo" }, allow_blank: true, on: :update
  validates :Costo_unitario, format: { with:  /\A\d+/, message: "El costo debe ser un valor númerico positivo" }, allow_blank: true, on: :update

end