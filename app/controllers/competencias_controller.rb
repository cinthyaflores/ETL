# frozen_string_literal: true

class CompetenciasController < ApplicationController
  def index
    @competencias_data = Competencia.using(:data_warehouse).all
    export
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
