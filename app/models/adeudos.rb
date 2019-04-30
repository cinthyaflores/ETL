class Adeudos < ApplicationRecord
  self.table_name = "Adeudos"
  validates :Cargo_Dia, format: { with: /\A\d+/, message: "El cargo debe ser un valor numérico positivo" }, on: :update
end