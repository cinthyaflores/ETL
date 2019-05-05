class Asistencia_alumno < ApplicationRecord
  self.table_name = "Asistencia_alumno_act"
  validates :Asistencias, format: { with: /\A\d+/, message: "Las asistencias deben ser un valor númerico positivo" }, allow_blank: true, on: :update
  validates :Faltas, format: { with: /\A\d+/, message: "Las faltas deben ser un valor númerico positivo" }, allow_blank: true, on: :update
  validates :Retardos, format: { with: /\A\d+/, message: "Los retardos deben ser un valor númerico positivo" }, allow_blank: true, on: :update
end