class HoraController < ApplicationController
  def index  
    @horas_data = Hora.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Hora.using(:data_warehouse).delete_all if !Hora.using(:data_warehouse).all.empty?

    @horas_ca = Hora.using(:controlA).all 

    @horas_ca.each do |hora|
      hora_new = Hora.using(:data_warehouse).new
      hora_new.Id_Hora = hora.Id_Hora
      hora_new.Hora_inicio = hora.Hora_inicio
      hora_new.Hora_fin = hora.Hora_fin
      hora_new.save!   
    end
  end
end
