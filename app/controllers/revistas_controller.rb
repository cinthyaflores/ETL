class RevistasController < ApplicationController
  def index
    @revistas_data = Revistas.using(:data_warehouse).all
    export
  end

  private

  def export
    Revistas.using(:data_warehouse).delete_all if !Revistas.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @revistas_biblio = @biblio.sheet("Revistas")

    @revistas_biblio.each_row_streaming(offset: 1) do |revista|
      @revista_new = Revistas.using(:data_warehouse).new
      @revista_new.idRevista = revista[0].value
      @revista_new.fecha_publicacion = revista[1].value
      @revista_new.No_paginas = revista[2].value
      @revista_new.Id_editorial = revista[3].value
      @revista_new.save!
    end
  end
end
