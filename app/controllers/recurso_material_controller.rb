class RecursoMaterialController < ApplicationController
  def init
    export
  end

  def index
    @recursos_data = Recurso_material.using(:data_warehouse).all
    export
  end

  private

    def export
      Recurso_material.using(:data_warehouse).delete_all if !Recurso_material.using(:data_warehouse).all.empty?

      @recursos_extra = Recurso_material.using(:extra).all 

      @recursos_extra.each do |recurso|
        recurso_new = Recurso_material.using(:data_warehouse).new
        recurso_new.Id_recurso = recurso.Id_recurso
        recurso_new.Area_pertenece = recurso.Area_pertenece
        recurso_new.Nombre = recurso.Nombre
        recurso_new.Cantidad = recurso.Cantidad
        recurso_new.Costo = recurso.Costo
        recurso_new.save!
      end
    end
end
