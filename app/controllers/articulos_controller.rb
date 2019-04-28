class ArticulosController < ApplicationController
  def index
    @articulos_data = Articulos.using(:data_warehouse).all
    export
  end

  private

  def export
    Articulos.using(:data_warehouse).delete_all if !Articulos.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @articulos_b = @biblio.sheet("Articulos")

    @articulos_b.each_row_streaming(offset: 1) do |art|
      @art_new = Articulos.using(:data_warehouse).new
      @art_new.idArticulo = art[0].value
      @art_new.fecha_publicacion = art[1].value
      @art_new.save!
    end
  end
end
