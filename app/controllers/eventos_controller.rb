class EventosController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Eventos.using(:data_warehouse).all.empty?
  end

  def index
    @eventos_data = Eventos.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Eventos.using(:data_warehouse_final).delete_all if !Eventos.using(:data_warehouse_final).all.empty?

    eventos = Eventos.using(:data_warehouse).all
    eventos.each do |data|
      Eventos.using(:data_warehouse_final).create(Id_evento: data.Id_evento,
        Nombre: data.Nombre, Descripcion: data.Descripcion,
        Fecha: data.Fecha, Tipo_evento: data.Tipo_evento)
    end
  end
  
  def data 
    actividades = Eventos.using(:data_warehouse).all
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
