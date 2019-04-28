class CalificacionesAlumnoController < ApplicationController
  def index
    @calificaciones_data = Calificaciones_alumno.using(:data_warehouse).all
    export
  end

  private

    def export
      Calificaciones_alumno.using(:data_warehouse).delete_all if !Calificaciones_alumno.using(:data_warehouse).all.empty?

      @calificaciones_extra = Calificaciones_alumno.using(:extra).all

      @calificaciones_extra.each do |calif|
        calif_new = Calificaciones_alumno.using(:data_warehouse).new
        calif_new.Id_Alumno = find_id_alumno(calif.No_control_a)
        calif_new.Id_nivel = calif.Id_nivel
        calif_new.Calificacion = calif.Calificacion
        calif_new.Unidad = calif.Unidad
        calif_new.Id_Periodo = calif.Id_periodo
        calif_new.save!
      end
    end
end
