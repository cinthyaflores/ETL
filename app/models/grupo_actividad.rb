# frozen_string_literal: true

class Grupo_actividad < ApplicationRecord
  self.table_name = "Grupo_Actividad"
  validates :Cupo, format: { with: /\A\d+/, message: "El cupo debe tener cantidades positivas" }, on: :update
end
