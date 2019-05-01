# frozen_string_literal: true

class Alumno < ApplicationRecord
  self.table_name = "Alumno"
  # SI NO ES EL PLURAL: self.table_name = 'nombre'
  validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
  validates :Curp, format: { with: /\A[A-Z]{4}+\d{6}+[A-Z]{6}+\d{2}\z/, message: "Formato de CURP: 4 letras mayúsculas + 6 números + 6 letras mayúsculas + 2 números" }, allow_blank: true, on: :update
  validates :Telefono, format: { with: /\A\d{10}\z/, message: "El número telefónico debe de ser de 10 dígitos" }, allow_blank: true, on: :update
  validates :telefono_extra, format: { with: /\A\d{10}\z/, message: "El número telefónico debe de ser de 10 dígitos" }, allow_blank: true, on: :update
  validates :Peso, format: { with: /\A\d+/, message: "El peso debe ser un valor númerico positivo" }, allow_blank: true, on: :update
  validates :Cre_acum, format: { with: /\A\d+/, message: "Los créditos deben ser un valor númerico positivo" }, allow_blank: true, on: :update
  validates :Promedio_G, format: { with: /\A\d+/, message: "El promedio debe ser un valor númerico positivo" }, allow_blank: true, on: :update
  validates :CorreoElec, format: { with: /\A([a-zA-Z\u00d1\u00f1\d]+)+@+(\w+)+\.+(\w+)\z/, message: "El E-mail debe de ser del formato correo@dominio.algo" }, on: :update
end
