class AreaMaestroController < ApplicationController
  def index  
    @area_maestro_data = Area_maestro.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Area_maestro.using(:data_warehouse).delete_all if !Area_maestro.using(:data_warehouse).all.empty?

    @area_maestro_ca = Area_maestro.using(:controlA).all 

    @area_maestro_ca.each do |area|
      area_new = Area_maestro.using(:data_warehouse).new
      area_new.Id_Area_mtro = area.Id_Area_mtro
      area_new.Nombre = area.Nombre
      area_new.Descripción = area.Descripcion
      area_new.save!   
    end
  end
end
