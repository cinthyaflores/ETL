class TipoPeliculaController < ApplicationController

  def init
    export
  end
  
  def empty
    return Tipo_pelicula.using(:data_warehouse).all.empty?
  end

  def index
    @tipo_pel_data = Tipo_pelicula.using(:data_warehouse).all
  end

  def export_to_sql
    Tipo_pelicula.using(:data_warehouse_final).delete_all if !Tipo_pelicula.using(:data_warehouse_final).all.empty?

    tipos = Tipo_pelicula.using(:data_warehouse).all
    tipos.each do |data|
      Tipo_pelicula.using(:data_warehouse_final).create(
        Id_Tipo_Pel: data.Id_Tipo_Pel, Nombre: data.Nombre)
    end
  end
  
  def data 
    tipo = Tipo_pelicula.using(:data_warehouse).all
  end

  private

  def export
    Tipo_pelicula.using(:data_warehouse).delete_all if !Tipo_pelicula.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @tipo_pel_b = @biblio.sheet("Tipo_Pelicula")

    @tipo_pel_b.each_row_streaming(offset: 1) do |tipo|
      @tipo_new = Tipo_pelicula.using(:data_warehouse).new
      @tipo_new.Id_Tipo_Pel = tipo[0].value
      @tipo_new.Nombre = tipo[1]
      @tipo_new.save!
    end
  end
end
