# frozen_string_literal: true

class TipoBajaController < ApplicationController

  def init
    export
  end
  
  def empty
    return Tipo_baja.using(:data_warehouse).all.empty?
  end

  def index
    @tipo_data = Tipo_baja.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Tipo_baja.using(:data_warehouse_final).delete_all if !Tipo_baja.using(:data_warehouse_final).all.empty?

    tipo = Tipo_baja.using(:data_warehouse).all
    tipo.each do |data|
      Tipo_baja.using(:data_warehouse_final).create(
        Id_Baja: data.Id_Baja, Nombre: data.Nombre)
    end
  end
  
  def data 
    actividades = Tipo_baja.using(:data_warehouse).all
  end

  private

    def export
      Tipo_baja.using(:data_warehouse).delete_all if !Tipo_baja.using(:data_warehouse).all.empty?

      @tipo_ca = Tipo_baja.using(:controlA).all

      @tipo_ca.each do |tipo|
        tipo_new = Tipo_baja.using(:data_warehouse).new
        tipo_new.Id_Baja = tipo.Id_Baja
        tipo_new.Nombre = tipo.Nombre
        tipo_new.save!
      end
    end
end
