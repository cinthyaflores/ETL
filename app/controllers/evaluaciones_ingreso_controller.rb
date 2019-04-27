# frozen_string_literal: true

class EvaluacionesIngresoController < ApplicationController
  def index
    @evaluaciones_data = Evaluaciones_ingreso.using(:data_warehouse).all
    export
  end

  private

    def export
      Evaluaciones_ingreso.using(:data_warehouse).delete_all if !Evaluaciones_ingreso.using(:data_warehouse).all.empty?

      @evaluaciones_ca = Evaluaciones_ingreso.using(:controlA).all

      @evaluaciones_ca.each do |evaluacion|
        evalu_new = Evaluaciones_ingreso.using(:data_warehouse).new
        evalu_new.Id_Evalu = evaluacion.Id_Evalu
        evalu_new.Id_Alumno = evaluacion.Id_Alumno
        evalu_new.Id_Pers = evaluacion.Id_Pers
        evalu_new.Id_Tipo_eva = evaluacion.Id_Tipo_eva
        evalu_new.Fecha_apl = evaluacion.Fecha_apl
        evalu_new.Resultado = evaluacion.Resultado
        evalu_new.save!
      end
    end
end
