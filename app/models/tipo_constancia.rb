# frozen_string_literal: true

class Tipo_constancia < ApplicationRecord
  self.table_name = "Tipo_constancia"

  # validates
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Costo, format: { with: /\A\d+/, message: "El costo debe ser un valor númerico positivo" }, allow_blank: true, on: :update
end
