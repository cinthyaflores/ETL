class LibrosController < ApplicationController
  def index
    @libros_data = Libro.using(:data_warehouse).all
    export
  end

  private

  def export
    Libro.using(:data_warehouse).delete_all if !Libro.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @libros_b = @biblio.sheet("Libro")

    @libros_b.each_row_streaming(offset: 1) do |libro|
      libro_new = Libro.using(:data_warehouse).new
      libro_new.idLibro = libro[0]
      libro_new.edicion = libro[1].value
      libro_new.aPublicacion = libro[2].value
      libro_new.ISBN = libro[3]
      libro_new.id_Editorial = libro[4].value
      libro_new.save!
    end
  end
end
