class PeliculasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Peliculas.using(:data_warehouse).all.empty?
  end

  def index
    @peliculas_data = Peliculas.using(:data_warehouse).all
  end

  def export_to_sql
    Peliculas.using(:data_warehouse_final).delete_all if !Peliculas.using(:data_warehouse_final).all.empty?

    peliculas = Peliculas.using(:data_warehouse).all
    peliculas.each do |data|
      Peliculas.using(:data_warehouse_final).create(
        idFilm: data.idFilm, director: data.director, 
        ann_publicacion: data.ann_publicacion,tipo_film: data.tipo_film, 
        id_productora: data.id_productora)
    end
  end
  
  def data 
    peliculas = Peliculas.using(:data_warehouse).all
  end

  private

  def export
    Peliculas.using(:data_warehouse).delete_all if !Peliculas.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @peliculas_b = @biblio.sheet("Peliculas")

    @peliculas_b.each_row_streaming(offset: 1) do |pelicula|
      @pelicula_new = Peliculas.using(:data_warehouse).new
      @pelicula_new.idFilm = pelicula[0]
      @pelicula_new.director = pelicula[1]
      @pelicula_new.ann_publicacion = pelicula[2].value
      @pelicula_new.tipo_film = pelicula[3].value
      @pelicula_new.id_productora = pelicula[4]
      @pelicula_new.save!
    end
  end
end
