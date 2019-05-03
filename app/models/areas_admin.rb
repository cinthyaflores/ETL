# frozen_string_literal: true

class Areas_admin < ApplicationRecord
  self.table_name = "Areas_Admin"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
end
