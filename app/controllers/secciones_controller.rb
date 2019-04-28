class SeccionesController < ApplicationController
  def index
    @secciones_data = Secciones.using(:data_warehouse).all
    export
  end

  private

  def export
    Secciones.using(:data_warehouse).delete_all if !Secciones.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @secciones_biblio = @biblio.sheet("Secciones")

    @secciones_biblio.each_row_streaming(offset: 1) do |seccion|
      @seccion_new = Secciones.using(:data_warehouse).new
      @seccion_new.id_Seccion = seccion[0].value
      @seccion_new.Nombre = seccion[1]
      @seccion_new.save!
    end
  end
end
