# frozen_string_literal: true

class BajasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Baja.using(:data_warehouse).all.empty?
  end

  def index
    @bajas_data = Baja.using(:data_warehouse).all
  end

  def export_to_sql
    Baja.using(:data_warehouse_final).delete_all if !Baja.using(:data_warehouse_final).all.empty?

    bajas = Baja.using(:data_warehouse).all
    bajas.each do |data|
      Baja.using(:data_warehouse_final).create(Id_Baja: data.Id_Baja,
        Id_Alumno: data.Id_Alumno, Id_Tipo_Baja: data.Id_Tipo_Baja, 
        Fecha_Baja: data.Fecha_Baja)
    end
  end
  
  def data 
    bajas = Baja.using(:data_warehouse).all
  end

  private

    def export
      Baja.using(:data_warehouse).delete_all if !Baja.using(:data_warehouse).all.empty?

      @bajas_ca = Baja.using(:controlA).all

      @bajas_ca.each do |baja|
        @baja_new = Baja.using(:data_warehouse).new
        @baja_new.Id_Baja = baja.Id_Baja
        @baja_new.Id_Alumno = baja.Id_Alumno
        @baja_new.Id_Tipo_Baja = baja.Id_Tipo_Baja
        @baja_new.Fecha_Baja = baja.Fecha_Baja
        @baja_new.save!
      end
    end
end
