class AsistenciaMaestroController < ApplicationController

  def init
    export
  end
  
  def empty
    return Asistencia_maestro.using(:data_warehouse).all.empty?
  end

  def index
    @asistencia_m = Asistencia_maestro.using(:data_warehouse).all
  end

  def export_to_sql
    Asistencia_maestro.using(:data_warehouse_final).delete_all if !Asistencia_maestro.using(:data_warehouse_final).all.empty?

    asistencia_m = Asistencia_maestro.using(:data_warehouse).all
    asistencia_m.each do |data|
      Asistencia_maestro.using(:data_warehouse_final).create(
        Id_maestro: data.Id_maestro, Id_Area_mtro: data.Id_Area_mtro, 
        Asistencias: data.Asistencias, Id_periodo: data.Id_periodo, 
        Faltas: data.Faltas, Retardos: data.Retardos)
    end
  end
  
  def data 
    asistencia_m = Asistencia_maestro.using(:data_warehouse).all
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
