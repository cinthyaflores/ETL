class MovilidadAlumnoPeriodoController < ApplicationController
  def index  
    @mov_alu_per_data = Movilidad_alumno_periodo.using(:data_warehouse).all.order(:Id_Alumno)
    export
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
