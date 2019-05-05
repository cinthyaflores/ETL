class Prestamos < ApplicationRecord
  self.table_name = "Prestamos"
  #validations

  validates :Estado, format: {with: /[1-3]{1}/, message: "El estado debe ser numérico entre 1 y 3" }, allow_blank: true, on: :update
end