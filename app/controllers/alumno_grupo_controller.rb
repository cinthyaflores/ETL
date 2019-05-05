# frozen_string_literal: true

class AlumnoGrupoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Alumno_grupo.using(:data_warehouse).all.empty?
  end

  def index
    @alumno_grupo_data = Alumno_grupo.using(:data_warehouse).all
  end

  def export_to_sql
    Alumno_grupo.using(:data_warehouse_final).delete_all if !Alumno_grupo.using(:data_warehouse_final).all.empty?

    alumno = Alumno_grupo.using(:data_warehouse).all
    alumno.each do |data|
      Alumno_grupo.using(:data_warehouse_final).create(Id_Grupo: data.Id_Grupo,
      Id_Alumno: data.Id_Alumno, Oportunidad: data.Oportunidad, 
      Promedio: data.Promedio)
    end
  end

  def data 
    alumno = Alumno_grupo.using(:data_warehouse).all
  end

  private

    def export
      Alumno_grupo.using(:data_warehouse).delete_all if !Alumno_grupo.using(:data_warehouse).all.empty?

      @alumno_grupo_ca = Alumno_grupo.using(:controlA).all

      @alumno_grupo_ca.each do |grupo|
        grupo_new = Alumno_grupo.using(:data_warehouse).new
        grupo_new.Id_Grupo = grupo.Id_Clase
        grupo_new.Id_Alumno = grupo.Id_Alumno
        grupo_new.Oportunidad = grupo.Oportunidad
        grupo_new.Promedio = grupo.Promedio
        grupo_new.save!
      end
    end
end
