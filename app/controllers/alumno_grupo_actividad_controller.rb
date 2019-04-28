class AlumnoGrupoActividadController < ApplicationController
  def index
    @alumno_grupo_data = Alumno_grupo_actividad.using(:data_warehouse).all.order(:Id_Alumno)
    export
  end

  private

    def export
      Alumno_grupo_actividad.using(:data_warehouse).delete_all if !Alumno_grupo_actividad.using(:data_warehouse).all.empty?

      @alumno_grupo_extra = Alumno_grupo_actividad.using(:extra).all

      @alumno_grupo_extra.each do |alumno|
        actividad_new = Alumno_grupo_actividad.using(:data_warehouse).new
        actividad_new.Id_Alumno = find_id_alumno(alumno.No_control_a)
        actividad_new.Id_grupo_Ac = alumno.Id_grupo_A
        actividad_new.Id_periodo = alumno.Id_periodo
        actividad_new.save!
      end
    end
end
