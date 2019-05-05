class ActividadExtraescolarController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Actividad_extraescolar.using(:data_warehouse).all.empty?
  end

  def index
    @actividad_data = Actividad_extraescolar.using(:data_warehouse).all
  end

  def export_to_sql
    Actividad_extraescolar.using(:data_warehouse_final).delete_all if !Actividad_extraescolar.using(:data_warehouse_final).all.empty?

    actividades = Actividad_extraescolar.using(:data_warehouse).all
    actividades.each do |data|
      Actividad_extraescolar.using(:data_warehouse_final).create(
        Id_actividad: data.Id_actividad, Nombre: data.Nombre, 
        Tipo_actividad: data.Tipo_actividad)
    end
  end
  
  def data 
    actividades = Actividad_extraescolar.using(:data_warehouse).all
  end

  private

    def export
      Actividad_extraescolar.using(:data_warehouse).delete_all if !Actividad_extraescolar.using(:data_warehouse).all.empty?

      @actividad_extra = Actividad_extraescolar.using(:extra).all

      Actividad_extraescolar.using(:data_warehouse).new
      @actividad_extra.each do |actividad|
        actividad_new = Actividad_extraescolar.using(:data_warehouse).new
        actividad_new.Id_actividad = actividad.Id_actividad
        actividad_new.Nombre = actividad.Nombre
        actividad_new.Tipo_actividad = actividad.Tipo
        actividad_new.save!
      end
    end
end
