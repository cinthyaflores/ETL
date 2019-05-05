class SeccionesController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Secciones.using(:data_warehouse).all.empty?
  end

  def index
    @secciones_data = Secciones.using(:data_warehouse).all
  end

  def export_to_sql
    Secciones.using(:data_warehouse_final).delete_all if !Secciones.using(:data_warehouse_final).all.empty?

    secciones = Secciones.using(:data_warehouse).all
    secciones.each do |data|
      Secciones.using(:data_warehouse_final).create(id_Seccion: data.id_Seccion, Nombre: data.Nombre)
    end
  end
  
  def data 
    secciones = Secciones.using(:data_warehouse).all
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
