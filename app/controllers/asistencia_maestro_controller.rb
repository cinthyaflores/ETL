class AsistenciaMaestroController < ApplicationController
  def index
    @asistencia_maestro_data = Asistencia_maestro.using(:data_warehouse).all
    export
  end

  private

    def export
      Asistencia_maestro.using(:data_warehouse).delete_all if !Asistencia_maestro.using(:data_warehouse).all.empty?

      @asistencia_maestro_extra = Asistencia_maestro.using(:extra).all

      @asistencia_maestro_extra.each do |asistencia|
        asistencia_new = Asistencia_maestro.using(:data_warehouse).new
        asistencia_new.Id_maestro = find_id_maestro(asistencia.Id_maestro_e)
        asistencia_new.Id_Area_mtro = area_maestro_id(asistencia.Id_maestro_e)
        asistencia_new.Id_periodo = asistencia.Id_periodo
        asistencia_new.Asistencias = asistencia.Asistencias
        asistencia_new.Faltas = asistencia.Faltas
        asistencia_new.Retardos = asistencia.Retardos
        asistencia_new.save!
      end
    end
end
