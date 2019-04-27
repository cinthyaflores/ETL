class Movilidad < ApplicationRecord
  self.table_name = 'Movilidad'
  #SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :País, format: { without: /\d+/, message: "El País debe de tener sólo letras" }, on: :update
  validates :Estado, format: { without: /\d+/, message: "El Estado debe de tener sólo letras" }, on: :update
end