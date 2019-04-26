class UnidadesController < ApplicationController
  def index  
    @unidades_data = Unidad.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Unidad.using(:data_warehouse).destroy_all
    @unidades_CA = Unidad.using(:controlA).all 

    @unidades_CA.each do |unidad|
      unidades_new = Unidad.using(:data_warehouse).new
      unidades_new.Id_Unidad = unidad.Id_Unidad
      unidades_new.Id_Materia = unidad.Id_Materia
      unidades_new.Nombre = unidad.Nombre
      unidades_new.save!   
    end
  end
end
