class Alumno < ApplicationRecord
    self.table_name = 'Alumno'
    #SI NO ES EL PLURAL: self.table_name = 'nombre'
    validates :Nombre, format: { without: /\d+/, message: "El nombre debe de tener sólo letras" }, on: :update
    validates :Curp, format: { with: /\A[A-Z]{4}+\d{6}+[A-Z]{6}+\d{2}\z/, message: "Formato de CURP: 4 letras, 6 numeros, 6 letras, 2 numeros" }, allow_blank: true, on: :update
    validates :Telefono, format: { with: /\A\d{10}\z/, message: "El número telefónico debe de ser de 10 dígitos" }, on: :update
    validates :Peso, format: { with: /\A\d+/, message: "El peso debe tener cantidades positivas" }, allow_blank: true, on: :update

end