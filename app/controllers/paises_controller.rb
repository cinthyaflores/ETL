class PaisesController < ApplicationController
  def index
    @paises_data = Paises.using(:data_warehouse).all
    export
  end

  private

  def export
    Paises.using(:data_warehouse).delete_all if !Paises.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @paises = @biblio.sheet("Paises")

    @paises.each_row_streaming(offset: 1) do |pais|
      @paises_new = Paises.using(:data_warehouse).new
      @paises_new.id_Pais = pais[0].to_s.to_i
      @paises_new.nombre_pais = pais[1]
      @paises_new.clave = pais[2]
      @paises_new.save!
    end
  end
end
