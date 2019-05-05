class Editorial < ApplicationRecord
  self.table_name = "Editoriales"

  #validations

  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Telefono, format: { with: /\A\d{10}\z/, message: "El número telefónico debe de ser de 10 dígitos" }, on: :update
end