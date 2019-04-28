class AreaRecreativaController < ApplicationController
  def index
    @area_rec_data = Area_recreativa.using(:data_warehouse).all
    export
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
