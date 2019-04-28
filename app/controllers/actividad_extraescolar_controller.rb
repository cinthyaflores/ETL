class ActividadExtraescolarController < ApplicationController
  def index
    @actividad_data = Actividad_extraescolar.using(:data_warehouse).all
    export
  end

  private

    def export
      Actividad_extraescolar.using(:data_warehouse).delete_all if !Actividad_extraescolar.using(:data_warehouse).all.empty?

      @actividad_extra = Actividad_extraescolar.using(:extra).all

      @actividad_extra.each do |actividad|
        actividad_new = Actividad_extraescolar.using(:data_warehouse).new
        actividad_new.Id_actividad = actividad.Id_actividad
        actividad_new.Nombre = actividad.Nombre
        actividad_new.Tipo_actividad = actividad.Tipo
        actividad_new.save!
      end
    end
end
