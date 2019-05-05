class AreaRecreativaController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Area_recreativa.using(:data_warehouse).all.empty?
  end
  
  def index
    @area_rec_data = Area_recreativa.using(:data_warehouse).all
  end

  def export_to_sql
    Area_recreativa.using(:data_warehouse_final).delete_all if !Area_recreativa.using(:data_warehouse_final).all.empty?

    area_rec_data = Area_recreativa.using(:data_warehouse).all
    area_rec_data.each do |data|
      Area_recreativa.using(:data_warehouse_final).create(Id_area_rec: data.Id_area_rec,
        Nombre: data.Nombre, Descripción: data.Descripción)
    end
  end
  
  def data 
    area_rec_data = Area_recreativa.using(:data_warehouse).all
  end

  private

    def export
      Area_recreativa.using(:data_warehouse).delete_all if !Area_recreativa.using(:data_warehouse).all.empty?

      @area_rec_extra = Area_recreativa.using(:extra).all

      @area_rec_extra.each do |area_rec|
        area_rec_new = Area_recreativa.using(:data_warehouse).new
        area_rec_new.Id_area_rec = area_rec.Id_area_rec
        area_rec_new.Nombre = area_rec.Nombre
        area_rec_new.Descripción = area_rec.Descripcion
        area_rec_new.save!
      end
    end
end
