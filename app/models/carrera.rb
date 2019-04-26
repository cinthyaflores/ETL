class Carrera < ApplicationRecord
    self.table_name = 'Carrera'
    #SI NO ES EL PLURAL: self.table_name = 'nombre'
    validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
end