class Calificaciones_alumno < ApplicationRecord
  self.table_name = "Calificaciones_alumno"

  validates :Calificacion, format: { with: /\A0*(?:[1-9][0-9]?|100)\z/, message: "La calificación debe ser entre 0 y 100" }, allow_blank: false, on: :update
end