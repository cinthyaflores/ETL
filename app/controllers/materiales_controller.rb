class MaterialesController < ApplicationController
  def index
    @materiales_data = Eventos_alumno.using(:data_warehouse).all
    export
  end

  private

  def export
    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @materiales = @biblio.sheet("Materiales")
    binding.pry
    @materiales.each do |material|
      
        @material_new = Eventos_alumno.using(:data_warehouse).new
        @material_new.id_Material = material[0]
        @material_new.nombre = material[1]
        @material_new.autor = material[2]
        # @material_new.existencia = 
        # @material_new.id_Pais = 
        # @material_new.Id_idioma= 
        # @material_new.Tipo_material = 
        # @material_new.Id_estante = 
    end
  end
end
