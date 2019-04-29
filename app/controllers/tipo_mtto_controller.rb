class TipoMttoController < ApplicationController
  def index
    @tipo_mtto_data = Tipo_mantenimiento.using(:data_warehouse).all
    export
  end

  private

  def export
    Tipo_mantenimiento.using(:data_warehouse).delete_all if !Tipo_mantenimiento.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @tipo_mtto_b = @biblio.sheet("Id_Tipo_Mtto")

    @tipo_mtto_b.each_row_streaming(offset: 1) do |tipo_mtto|
      tipo_mtto_new = Tipo_mantenimiento.using(:data_warehouse).new
      tipo_mtto_new.id_Tipo_Mtto = tipo_mtto[0].value
      tipo_mtto_new.Nombre = tipo_mtto[1]
      tipo_mtto_new.Costo = tipo_mtto[2].value
      tipo_mtto_new.save!
    end
  end
end
