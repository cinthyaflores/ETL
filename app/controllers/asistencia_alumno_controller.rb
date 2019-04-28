class AsistenciaAlumnoController < ApplicationController
  def index
    @asistencia_alumno_data = Asistencia_alumno.using(:data_warehouse).all
    export
  end

  private

    def export
      Asistencia_alumno.using(:data_warehouse).delete_all if !Asistencia_alumno.using(:data_warehouse).all.empty?

      @asistencia_alumno_extra = Asistencia_alumno.using(:extra).all

      @asistencia_alumno_extra.each do |asistencia|
        asistencia_new = Asistencia_alumno.using(:data_warehouse).new
        asistencia_new.Id_alumno = find_id_alumno(asistencia.No_control_a)
        asistencia_new.Id_Periodo = asistencia.Id_periodo
        asistencia_new.Asistencias = asistencia.Asistencias
        asistencia_new.Faltas = asistencia.Faltas
        asistencia_new.Retardos = asistencia.Retardos
        asistencia_new.save!
      end
    end
end
