# frozen_string_literal: true

class Maestro < ApplicationRecord
  self.table_name = "Maestro"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Telefono, format: { with: /\A\d{10}\z/, message: "El número telefónico debe de ser de 10 dígitos" }, on: :update
  validates :CorreoElec, format: { with: /\A([a-zA-Z\u00d1\u00f1\d]+)+@+(\w+)+\.+(\w+)\z/, message: "El E-mail debe de ser del formato correo@dominio.algo" }, on: :update
end
