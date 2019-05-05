class EstantesController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Estante.using(:data_warehouse).all.empty?
  end

  def index
    @estantes_data = Estante.using(:data_warehouse).all
  end

  def export_to_sql
    Estante.using(:data_warehouse_final).delete_all if !Estante.using(:data_warehouse_final).all.empty?

    estantes = Estante.using(:data_warehouse).all
    estantes.each do |data|
      Estante.using(:data_warehouse_final).create(id_Estante: data.id_Estante,
        Id_Seccion: data.Id_Seccion, Clave: data.Clave)
    end
  end
  
  def data 
    estantes = Estante.using(:data_warehouse).all
  end

  private

  def export
    Estante.using(:data_warehouse).delete_all if !Estante.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @estantes_biblio = @biblio.sheet("Estante")

    @estantes_biblio.each_row_streaming(offset: 1) do |estante|
      @estante_new = Estante.using(:data_warehouse).new
      @estante_new.id_Estante = estante[0].to_s
      @estante_new.Id_Seccion = estante[1].to_s
      @estante_new.Clave = estante[2]
      @estante_new.save!
    end
  end
end
