class EventosController < ApplicationController
  def index
    @eventos_data = Eventos.using(:data_warehouse).all
    export
  end

  private

    def export
      Eventos.using(:data_warehouse).delete_all if !Eventos.using(:data_warehouse).all.empty?

      @eventos_extra = Eventos.using(:extra).all

      @eventos_extra.each do |evento|
        evento_new = Eventos.using(:data_warehouse).new
        evento_new.Id_evento = evento.Id_evento
        evento_new.Nombre = evento.Nombre
        evento_new.Descripcion = evento.Descripcion
        evento_new.Fecha = evento.Fecha
        evento_new.Tipo_evento = evento.Tipo_evento
        evento_new.save!
      end
    end
end
