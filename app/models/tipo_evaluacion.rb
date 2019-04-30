class Tipo_evaluacion < ApplicationRecord
  self.table_name = "Tipo_Evaluacion"
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
end