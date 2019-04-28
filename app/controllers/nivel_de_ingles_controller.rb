class NivelDeInglesController < ApplicationController
  def init
    export
  end

  def index
    @niveles_data = Nivel_de_ingles.using(:data_warehouse).all
    export
  end

  private

    def export
      Nivel_de_ingles.using(:data_warehouse).delete_all if !Nivel_de_ingles.using(:data_warehouse).all.empty?

      @niveles_extra = Nivel_de_ingles.using(:extra).all 

      @niveles_extra.each do |nivel|
        nivel_new = Nivel_de_ingles.using(:data_warehouse).new
        nivel_new.Id_Nivel = nivel.Id_Nivel
        nivel_new.Nombre = nivel.Nombre
        nivel_new.Descripcion = nivel.Descripción
        nivel_new.save!
      end
    end
end
