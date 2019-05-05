class EvaluacionesIngresoController < ApplicationController
  def init
    export
  end

  def empty
    return Evaluaciones_ingreso.using(:data_warehouse).all.empty?
  end

  def index
    @evaluaciones_data = Evaluaciones_ingreso.using(:data_warehouse).all
  end

  def export_to_sql
    Evaluaciones_ingreso.using(:data_warehouse_final).delete_all if !Evaluaciones_ingreso.using(:data_warehouse_final).all.empty?

    actividades = Evaluaciones_ingreso.using(:data_warehouse).all
    actividades.each do |data|
      Evaluaciones_ingreso.using(:data_warehouse_final).create(
          Id_Evalu: data.Id_Evalu, Id_Alumno: data.Id_Alumno,
          Id_Pers: data.Id_Pers, Id_Tipo_eva: data.Id_Tipo_eva,
          Fecha_apl: data.Fecha_apl, Resultado: data.Resultado)
    end
  end

  def data
    actividades = Evaluaciones_ingreso.using(:data_warehouse).all
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
