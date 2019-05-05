class Perdidas_materiales < ApplicationRecord
  self.table_name = "Perdidas_materiales"
  # Validates

  validates :Costo_total, format: { with: /\A\d+/, message: "El costo debe ser un valor númerico positivo y sin símbolos" }, allow_blank: true, on: :update
  validates :Cantidad, format: { with: /\A\d+/, message: "La catidad debe ser un valor númerico positivo" }, allow_blank: true, on: :update
end