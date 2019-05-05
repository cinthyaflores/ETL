class Materiales < ApplicationRecord
  self.table_name = "Material"
  #validations

  validates :autor, format: { without: /\d+/, message: "El Autor debe de tener sólo letras" }, on: :update
  validates :existencia, format: { with: /\A\d+/, message: "La existencia ser un valor númerico positivo" }, on: :update

end