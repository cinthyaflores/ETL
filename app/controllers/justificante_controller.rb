# frozen_string_literal: true

class JustificanteController < ApplicationController

  def init
    export
  end
  
  def empty
    return Justificante.using(:data_warehouse).all.empty?
  end

  def index
    @justificantes_data = Justificante.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Justificante.using(:data_warehouse_final).delete_all if !Justificante.using(:data_warehouse_final).all.empty?

    justificantes = Justificante.using(:data_warehouse).all
    justificantes.each do |data|
      Justificante.using(:data_warehouse_final).create(Id_Alumno: data.Id_Alumno,
        Id_Just: data.Id_Just, Id_Personal: data.Id_Personal, 
        Fecha_ini: data.Fecha_ini, 
        Fecha_fin: data.Fecha_fin, 
        Causa: data.Causa, 
        Fecha_elab: data.Fecha_elab)
    end
  end
  
  def data 
    justificantes = Justificante.using(:data_warehouse).all
  end

  private

    def export
      Justificante.using(:data_warehouse).delete_all if !Justificante.using(:data_warehouse).all.empty?

      @justificantes_ca = Justificante.using(:controlA).all

      @justificantes_ca.each do |just|
        just_new = Justificante.using(:data_warehouse).new
        just_new.Id_Just = just.Id_Just
        just_new.Id_Alumno = just.Id_Alumno
        just_new.Id_Personal = just.Id_Personal
        just_new.Fecha_ini = just.Fecha_ini
        just_new.Fecha_fin = just.Fecha_fin
        just_new.Causa = just.Causa
        just_new.Fecha_elab = just.Fecha_elab
        just_new.save!
      end
    end
end
