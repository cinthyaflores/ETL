class Orden_de_compra < ApplicationRecord
  self.table_name = "Orden_de_compra"

  #validations
  validates :Costo, format: { with: /\A\d+/, message: "El costo debe ser un valor númerico positivo y sin símbolos" }, allow_blank: true, on: :update
  validates :Estado, format: { with: /\A[1-2]{1}\z/, message: "El estado sólo puede ser 1 (Activo) o 2 (Inactivo)" }, on: :update
end
