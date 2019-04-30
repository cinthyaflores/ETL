# frozen_string_literal: true

class Area_maestro < ApplicationRecord
  self.table_name = "Area_maestro"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
end
