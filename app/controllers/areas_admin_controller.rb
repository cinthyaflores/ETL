class AreasAdminController < ApplicationController
  def index  
    @areas_admin_data = Areas_admin.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Areas_admin.using(:data_warehouse).delete_all if !Areas_admin.using(:data_warehouse).all.empty?

    @areas_admin_ca = Areas_admin.using(:controlA).all 

    @areas_admin_ca.each do |area|
      area_admin_new = Areas_admin.using(:data_warehouse).new
      area_admin_new.Id_Area = area.Id_Area
      area_admin_new.Nombre = area.Nombre
      area_admin_new.Descr = area.Descr
      area_admin_new.save!   
    end
  end
end
