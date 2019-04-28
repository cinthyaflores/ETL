class HorariosAreaController < ApplicationController
  def init
    export
  end

  def index
    @horarios_data = Horarios_area.using(:data_warehouse).all
    export
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
