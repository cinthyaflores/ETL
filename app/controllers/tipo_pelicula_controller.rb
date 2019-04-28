class TipoPeliculaController < ApplicationController
  def index
    @tipo_pel_data = Tipo_pelicula.using(:data_warehouse).all
    export
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
