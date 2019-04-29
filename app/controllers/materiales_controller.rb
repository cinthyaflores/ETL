class MaterialesController < ApplicationController
  
  def index
    @materiales_data = Materiales.using(:data_warehouse).all
    export
  end

  private

  def export
    Materiales.using(:data_warehouse).delete_all if !Materiales.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @materiales = @biblio.sheet("Materiales")
    
    @materiales.each_row_streaming(offset: 1) do |material|
      @material_new = Materiales.using(:data_warehouse).new
      @material_new.id_Material = material[0].value
      @material_new.nombre = material[1]
      @material_new.autor = material[2]
      @material_new.existencia = material[3].value
      @material_new.id_Pais = material[4].value
      @material_new.Id_idioma= material[5].value
      @material_new.Tipo_Material = material[6]
      @material_new.Id_Estante = material[7].value
      @material_new.save!
    end
  end
end
