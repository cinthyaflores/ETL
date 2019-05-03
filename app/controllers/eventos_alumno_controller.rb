class EventosAlumnoController < ApplicationController
  def init
    export
  end
  
  def empty
    return Eventos_alumno.using(:data_warehouse).all.empty?
  end

  def index
    @eventos_data = Eventos_alumno.using(:data_warehouse).all
  end

  def export_to_sql
    Eventos_alumno.using(:data_warehouse_final).delete_all if !Eventos_alumno.using(:data_warehouse_final).all.empty?

    eventos = Eventos_alumno.using(:data_warehouse).all
    eventos.each do |data|
      Eventos_alumno.using(:data_warehouse_final).create(Id_Alumno: data.Id_Alumno,
        Id_evento_e: data.Id_evento_e, Id_periodo_e: data.Id_periodo_e)
    end
  end
  
  def data 
    eventos = Eventos_alumno.using(:data_warehouse).all
  end

  private

    def export
      Eventos_alumno.using(:data_warehouse).delete_all if !Eventos_alumno.using(:data_warehouse).all.empty?

      @eventos_extra = Eventos_alumno.using(:extra).all

      @eventos_extra.each do |ev|
        evento_new = Eventos_alumno.using(:data_warehouse).new
        evento_new.Id_Alumno = find_id_alumno(ev.No_control_a)
        evento_new.Id_evento_e = ev.Id_evento_e
        evento_new.Id_periodo_e = ev.Id_periodo_e
        evento_new.save!
      end
    end
end
