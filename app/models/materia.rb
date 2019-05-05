# frozen_string_literal: true

class Materia < ApplicationRecord
  self.table_name = "Materia"
  #validations
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Créditos, format: { with: /\A[1-9]$|^0[1-9]$|^1[0-9]$|^20\z/, message: "Los créditos son del 1 al 20" }, on: :update
end
