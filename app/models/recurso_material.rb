class Recurso_material < ApplicationRecord
  self.table_name = "Recurso_Material"
  # Validations
  #
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Costo, format: { with: /\A\d+/, message: "El costo debe ser un valor númerico positivo y sin símbolos" }, allow_blank: true, on: :update
  validates :Cantidad, format: { with: /\A\d+/, message: "La catidad debe ser un valor númerico positivo" }, allow_blank: true, on: :update
end
