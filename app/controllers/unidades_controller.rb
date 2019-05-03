# frozen_string_literal: true

class UnidadesController < ApplicationController

  def init
    export
  end
  
  def empty
    return Unidad.using(:data_warehouse).all.empty?
  end

  def index
    @unidades_data = Unidad.using(:data_warehouse).all
  end

  def export_to_sql
    Unidad.using(:data_warehouse_final).delete_all if !Unidad.using(:data_warehouse_final).all.empty?

    unidades = Unidad.using(:data_warehouse).all
    unidades.each do |data|
      Unidad.using(:data_warehouse_final).create(Id_Unidad: data.Id_Unidad,
        Id_Materia: data.Id_Materia, Nombre: data.Nombre)
    end
  end
  
  def data 
    unidades = Unidad.using(:data_warehouse).all
  end

  private

    def export
      Unidad.using(:data_warehouse).destroy_all
      @unidades_CA = Unidad.using(:controlA).all

      @unidades_CA.each do |unidad|
        unidades_new = Unidad.using(:data_warehouse).new
        unidades_new.Id_Unidad = unidad.Id_Unidad
        unidades_new.Id_Materia = unidad.Id_Materia
        unidades_new.Nombre = unidad.Nombre
        unidades_new.save!
      end
    end
end
