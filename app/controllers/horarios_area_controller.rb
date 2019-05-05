class HorariosAreaController < ApplicationController

  def init
    export
  end
  
  def empty
    return Horarios_area.using(:data_warehouse).all.empty?
  end

  def index
    @horarios_data = Horarios_area.using(:data_warehouse).all
  end

  def export_to_sql
    Horarios_area.using(:data_warehouse_final).delete_all if !Horarios_area.using(:data_warehouse_final).all.empty?

    actividades = Horarios_area.using(:data_warehouse).all
    Horarios_area.using(:data_warehouse_final).new
    actividades.each do |data|
      Horarios_area.using(:data_warehouse_final).create(
        Id_area: data.Id_area, Hora_inicio: data.Hora_inicio, 
        Hora_fin: data.Hora_fin)
    end
  end
  
  def data 
    actividades = Horarios_area.using(:data_warehouse).all
  end

  private

    def export
      Horarios_area.using(:data_warehouse).delete_all if !Horarios_area.using(:data_warehouse).all.empty?

      @horarios_extra = Horarios_area.using(:extra).all 

      @horarios_extra.each do |hora|
        hora_new = Horarios_area.using(:data_warehouse).new
        hora_new.Id_area = hora.Id_area
        hora_new.Hora_inicio = hora.Hora_inicio
        hora_new.Hora_fin = hora.Hora_fin
        hora_new.save!
      end
    end
end
