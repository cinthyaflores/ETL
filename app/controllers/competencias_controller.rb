# frozen_string_literal: true

class CompetenciasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Competencia.using(:data_warehouse).all.empty?
  end

  def index
    @competencias_data = Competencia.using(:data_warehouse).all
  end

  def export_to_sql
    Competencia.using(:data_warehouse_final).delete_all if !Competencia.using(:data_warehouse_final).all.empty?

    competencias = Competencia.using(:data_warehouse).all
    competencias.each do |data|
      Competencia.using(:data_warehouse_final).create(Id_Compet: data.Id_Compet,
        Id_Unidad: data.Id_Unidad, Descripción: data.Descripción)
    end
  end
  
  def data 
    competencias = Competencia.using(:data_warehouse).all
  end

  private

    def export
      Competencia.using(:data_warehouse).delete_all if !Competencia.using(:data_warehouse).all.empty?

      @competencias_ca = Competencia.using(:controlA).all

      @competencias_ca.each do |competencia|
        alum_comp_new = Competencia.using(:data_warehouse).new
        alum_comp_new.Id_Compet = competencia.Id_Compet
        alum_comp_new.Id_Unidad = competencia.Id_Unidad
        alum_comp_new.Descripción = competencia.Descripción
        alum_comp_new.save!
      end
    end
end
