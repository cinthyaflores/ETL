# frozen_string_literal: true

class HoraController < ApplicationController

  def init
    export
  end
  
  def empty
    return Hora.using(:data_warehouse).all.empty?
  end
  
  def index
    @horas_data = Hora.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Hora.using(:data_warehouse_final).delete_all if !Hora.using(:data_warehouse_final).all.empty?

    horas = Hora.using(:data_warehouse).all
    Hora.using(:data_warehouse_final).new
    horas.each do |datos|
      Hora.using(:data_warehouse_final).create(Id_Hora: datos.Id_Hora,
        Hora_inicio: datos.Hora_inicio.to_s , Hora_fin: datos.Hora_fin.to_s)
        puts datos.Hora_inicio.to_s
    end
  end
  
  def data 
    horas = Hora.using(:data_warehouse).all
  end

  private

    def export
      Hora.using(:data_warehouse).delete_all if !Hora.using(:data_warehouse).all.empty?

      @horas_ca = Hora.using(:controlA).all

      @horas_ca.each do |hora|
        hora_new = Hora.using(:data_warehouse).new
        hora_new.Id_Hora = hora.Id_Hora
        hora_new.Hora_inicio = hora.Hora_inicio.to_s
        hora_new.Hora_fin = hora.Hora_fin.to_s
        hora_new.save!
      end
    end
end
