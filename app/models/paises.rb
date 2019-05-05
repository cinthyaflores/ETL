class Paises < ApplicationRecord
  self.table_name = "Paises"
  #validations

  validates :nombre_pais, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :clave, format: { with: /\A[A-Z]{3}\z/, message: "La clave deben ser 3 letras mayusculas" }, on: :update
end