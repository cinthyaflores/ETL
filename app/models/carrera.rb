# frozen_string_literal: true

class Carrera < ApplicationRecord
  self.table_name = "Carrera"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Creditos, format: { with: /\A\d+/, message: "Los créditos deben ser un valor númerico positivo" }, allow_blank: true, on: :update
end
