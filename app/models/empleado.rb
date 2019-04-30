class Empleado < ApplicationRecord
  self.table_name = "Empleado"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :nombre_empleado, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :telefono, format: { with: /\A[0-9]{10}\z/, message: "El número de teléfono debe tener 10 número" }, on: :update
  validates :email, format: { with:  /\A(\w+)+@+(\w+)+\.+(\w+)\z/, message: "El correo debe de ser de la forma correo@dominio.com" }, on: :update
end