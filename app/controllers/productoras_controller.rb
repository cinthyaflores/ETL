class ProductorasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Productora.using(:data_warehouse).all.empty?
  end

  def index
    @productoras_data = Productora.using(:data_warehouse).all
  end

  def export_to_sql
    Productora.using(:data_warehouse_final).delete_all if !Productora.using(:data_warehouse_final).all.empty?

    productoras = Productora.using(:data_warehouse).all
    productoras.each do |data|
      Productora.using(:data_warehouse_final).create(
        idProductora: data.idProductora, Nombre: data.Nombre, 
        Ano_Fund: data.Ano_Fund,Id_Pais: data.Id_Pais)
    end
  end
  
  def data 
    productoras = Productora.using(:data_warehouse).all
  end

  private

  def export
    Productora.using(:data_warehouse).delete_all if !Productora.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @productoras_b = @biblio.sheet("Productoras")

    @productoras_b.each_row_streaming(offset: 1) do |produ|
      @produ_new = Productora.using(:data_warehouse).new
      @produ_new.idProductora = produ[0]
      @produ_new.Nombre = produ[1]
      @produ_new.Ano_Fund = produ[2].value
      @produ_new.Id_Pais = produ[3].value
      @produ_new.save!
    end
  end
end
