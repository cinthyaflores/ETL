class IdiomasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Idioma.using(:data_warehouse).all.empty?
  end

  def index
    @idiomas_data = Idioma.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Idioma.using(:data_warehouse_final).delete_all if !Idioma.using(:data_warehouse_final).all.empty?

    idiomas = Idioma.using(:data_warehouse).all
    idiomas.each do |data|
      Idioma.using(:data_warehouse_final).create(
        Id_Idioma: data.Id_Idioma, nombre: data.nombre, 
        codigo: data.codigo)
    end
  end
  
  def data 
    idiomas = Idioma.using(:data_warehouse).all
  end

  private

  def export
    Idioma.using(:data_warehouse).delete_all if !Idioma.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @idiomas_biblio = @biblio.sheet("Idiomas")

    @idiomas_biblio.each_row_streaming(offset: 1) do |idioma|
      @idiomas_new = Idioma.using(:data_warehouse).new
      @idiomas_new.Id_Idioma = idioma[0].to_s
      @idiomas_new.nombre = idioma[1]
      @idiomas_new.codigo = idioma[2]
      @idiomas_new.save!
    end
  end
end
