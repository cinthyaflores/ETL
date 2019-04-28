class ActividadesPorAlumnoController < ApplicationController
  def index
    @actividades_data = Actividades_por_alumno.using(:data_warehouse).all
    export
  end

  private

    def export
      Actividades_por_alumno.using(:data_warehouse).delete_all if !Actividades_por_alumno.using(:data_warehouse).all.empty?

      @actividades_ex = Actividades_por_alumno.using(:extra).all

      @actividades_ex.each do |actividad|
        actividad_new = Actividades_por_alumno.using(:data_warehouse).new
        actividad_new.Id_Alumno = find_id_alumno(actividad.No_control_a)
        actividad_new.Id_actividad = actividad.Id_actividad
        actividad_new.Id_Periodo = actividad.Id_periodo
        actividad_new.Num_Credito_obtenido = actividad.Creditos
        actividad_new.save!
      end
    end
end
