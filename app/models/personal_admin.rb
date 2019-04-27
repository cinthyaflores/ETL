# frozen_string_literal: true

class Personal_Admin < ApplicationRecord
  self.table_name = "Personal_Admin"
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Estado, format: { with: /\A[1-2]{1}\z/, message: "El estado sólo puede ser 1 (Activo) o 2 (Inactivo)" }, on: :update
end
