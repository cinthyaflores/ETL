class Actividades_por_alumno < ApplicationRecord
  self.table_name = "Actividades_por_alumno"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :Num_Credito_obtenido, format: { with: /\A\d+/, message: "El número de créditos debe ser un valor númerico positivo" }, allow_blank: true, on: :update
end