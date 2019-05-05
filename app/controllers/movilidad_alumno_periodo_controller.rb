# frozen_string_literal: true

class MovilidadAlumnoPeriodoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Movilidad_alumno_periodo.using(:data_warehouse).all.empty?
  end

  def index
    @mov_alu_per_data = Movilidad_alumno_periodo.using(:data_warehouse).all.order(:Id_Alumno)
  end

  def export_to_sql
    Movilidad_alumno_periodo.using(:data_warehouse_final).delete_all if !Movilidad_alumno_periodo.using(:data_warehouse_final).all.empty?

    movilidad = Movilidad_alumno_periodo.using(:data_warehouse).all
    movilidad.each do |data|
      Movilidad_alumno_periodo.using(:data_warehouse_final).create(Id_Movilidad: data.Id_Movilidad,
        Id_Alumno: data.Id_Alumno, Id_Periodo: data.Id_Periodo)
    end
  end
  
  def data 
    movilidad = Movilidad_alumno_periodo.using(:data_warehouse).all
  end

  private

    def export
      Movilidad_alumno_periodo.using(:data_warehouse).delete_all if !Movilidad_alumno_periodo.using(:data_warehouse).all.empty?

      @mov_alu_per_ca = Movilidad_alumno_periodo.using(:controlA).all

      @mov_alu_per_ca.each do |mov_alu|
        mov_alu_new = Movilidad_alumno_periodo.using(:data_warehouse).new
        mov_alu_new.Id_Movilidad = mov_alu.Id_Movilidad
        mov_alu_new.Id_Alumno = mov_alu.Id_Alumno
        mov_alu_new.Id_Periodo = mov_alu.Id_Periodo
        mov_alu_new.save!
      end
    end
end
