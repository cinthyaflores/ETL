# frozen_string_literal: true

class Grupo < ApplicationRecord
  self.table_name = "Grupo"
  validates :Clave, format: { with: /\A[A-Z]{2}+\d{4}\z/, message: "La clave debe de ser en formato [A-Z][A-Z][0-9][0-9][0-9][0-9]" }, on: :update
end
