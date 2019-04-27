# frozen_string_literal: true

class AlumnoGrupoController < ApplicationController
  def index
    @alumno_grupo_data = Alumno_grupo.using(:data_warehouse).all
    export
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
