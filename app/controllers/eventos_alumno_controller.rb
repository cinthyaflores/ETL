class EventosAlumnoController < ApplicationController
  def init
    export
  end

  def index
    @eventos_data = Eventos_alumno.using(:data_warehouse).all
    export
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
