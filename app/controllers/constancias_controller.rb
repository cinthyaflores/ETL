# frozen_string_literal: true

class ConstanciasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Constancia.using(:data_warehouse).all.empty?
  end

  def index
    @constancias_data = Constancia.using(:data_warehouse).all
  end

  def export_to_sql
    Constancia.using(:data_warehouse_final).delete_all if !Constancia.using(:data_warehouse_final).all.empty?

    constancias = Constancia.using(:data_warehouse).all
    constancias.each do |data|
      Constancia.using(:data_warehouse_final).create(Id_Const: data.Id_Const,
        Id_Alumno: data.Id_Alumno, Id_Personal: data.Id_Personal, 
        Id_Tipo_Con: data.Id_Tipo_Con, 
        Fecha_elab: data.Fecha_elab)
    end
  end
  
  def data 
    constancias = Constancia.using(:data_warehouse).all
  end

  private

    def export
      Constancia.using(:data_warehouse).delete_all if !Constancia.using(:data_warehouse).all.empty?

      @constancias_ca = Constancia.using(:controlA).all

      @constancias_ca.each do |constancia|
        const_new = Constancia.using(:data_warehouse).new
        const_new.Id_Const = constancia.Id_Const
        const_new.Id_Alumno = constancia.Id_Alumno
        const_new.Id_Personal = constancia.Id_Personal
        const_new.Id_Tipo_Con = constancia.Id_Tipo_Con
        const_new.Fecha_elab = constancia.Fecha_elab
        const_new.save!
      end
    end
end
