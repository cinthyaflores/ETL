# frozen_string_literal: true

class AlumnoCompController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Alumno_comp.using(:data_warehouse).all.empty?
  end
  
  def index
    @alum_comp_data = Alumno_comp.using(:data_warehouse).all.order(:Id_Alumno)
  end

  def export_to_sql
    Alumno_comp.using(:data_warehouse_final).delete_all if !Alumno_comp.using(:data_warehouse_final).all.empty?

    alum_comp_data = Alumno_comp.using(:data_warehouse).all
    alum_comp_data.each do |data|
      Alumno_comp.using(:data_warehouse_final).create(Id_Compet: data.Id_Compet,
      Id_Alumno: data.Id_Alumno, Oportunidad: data.Oportunidad, 
      Calificación: data.Calificación)
    end
  end
  
  def data 
    actividades = Alumno_comp.using(:data_warehouse).all
  end

  private

    def export
      Alumno_comp.using(:data_warehouse).delete_all if !Alumno_comp.using(:data_warehouse).all.empty?

      @alum_comp_CA = Alumno_comp.using(:controlA).all

      @alum_comp_CA.each do |detalle|
        alum_comp_new = Alumno_comp.using(:data_warehouse).new
        if validate_oportunidad(detalle.Oportunidad) == false
          alum_comp_new.error = 1
        end
        alum_comp_new.Id_Compet = detalle.Id_Compet
        alum_comp_new.Id_Alumno = detalle.Id_Alumno
        alum_comp_new.Oportunidad = detalle.Oportunidad
        alum_comp_new.Calificación = detalle.Calificación
        alum_comp_new.save!
      end
    end
end
