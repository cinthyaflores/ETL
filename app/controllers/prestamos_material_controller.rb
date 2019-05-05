class PrestamosMaterialController < ApplicationController

  def init
    export
  end
  
  def empty
    return Prestamos_material.using(:data_warehouse).all.empty?
  end

  def index
    @prestamo_mat = Prestamos_material.using(:data_warehouse).all
  end

  def export_to_sql
    Prestamos_material.using(:data_warehouse_final).delete_all if !Prestamos_material.using(:data_warehouse_final).all.empty?

    prestamos = Prestamos_material.using(:data_warehouse).all
    Prestamos_material.using(:data_warehouse_final).new
    prestamos.each do |data|
      Prestamos_material.using(:data_warehouse_final).create(Id_Prestamo_Mat: data.Id_Prestamo_Mat,
        fec_salida: data.fec_salida, fec_entrega: data.fec_entrega, 
        id_Material: data.id_Material, Id_Solicitante: data.Id_Solicitante,
        Tipo_Solicitante: data.Tipo_Solicitante, id_Empleado: data.id_Empleado, 
        tipo_prestamo: data.tipo_prestamo)
    end
  end
  
  def data 
    prestamos = Prestamos_material.using(:data_warehouse).all
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
