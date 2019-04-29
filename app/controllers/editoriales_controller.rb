class EditorialesController < ApplicationController
  
  def index
    @editoriales_data = Editorial.using(:data_warehouse).all
    export
  end

  private

  def export
    Editorial.using(:data_warehouse).delete_all if !Editorial.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @editoriales_b = @biblio.sheet("Editoriales")

    @editoriales_b.each_row_streaming(offset: 1) do |editorial|
      editorial_new = Editorial.using(:data_warehouse).new
      editorial_new.Id_Editorial = editorial[0].value
      editorial_new.Nombre = editorial[1].value
      editorial_new.CP = editorial[2].value
      editorial_new.Direccion = editorial[3]
      editorial_new.Telefono = editorial[4]
      editorial_new.Id_Pais = editorial[5].value
      editorial_new.save!
    end
  end
end
