class PrestamosMaterialController < ApplicationController

  def index
    @prestamo_mat = Prestamos_material.using(:data_warehouse).all
    export
  end

  private

  def export
    Prestamos_material.using(:data_warehouse).delete_all if !Prestamos_material.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    prestamo_mat_bi = @biblio.sheet("Prestamos_Material")

    prestamo_mat_bi.each_row_streaming(offset: 1) do |prestamo_b| # Ingresar los que no existen en Control Academico
      area_new = Prestamos_material.using(:data_warehouse).new
      area_new.Id_Prestamo_Mat = prestamo_b[0].value
      area_new.fec_salida = prestamo_b[1].value
      area_new.fec_entrega = prestamo_b[2].value
      area_new.id_Material = prestamo_b[3].value
      area_new.Id_Solicitante = prestamo_b[4].value
      area_new.Tipo_Solicitante = prestamo_b[5].value
      area_new.id_Empleado = prestamo_b[6].value
      area_new.tipo_prestamo = prestamo_b[7].value
      area_new.save!
    end
  end
  
end
