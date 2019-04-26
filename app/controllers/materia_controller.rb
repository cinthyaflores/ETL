class MateriaController < ApplicationController
  def index  
    @materias_data = Materia.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Materia.using(:data_warehouse).delete_all if !Materia.using(:data_warehouse).all.empty?

    @materias_ca = Materia.using(:controlA).all 

    @materias_ca.each do |materia|
      materia_new = Materia.using(:data_warehouse).new
      materia_new.Id_Materia = materia.Id_Materia
      materia_new.Nombre = materia.Nombre
      materia_new.Clave = materia.Clave
      materia_new.Créditos = materia.Créditos
      materia_new.save!   
    end
  end
end
