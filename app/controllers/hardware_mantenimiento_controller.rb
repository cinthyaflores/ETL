class HardwareMantenimientoController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Hardware_mantenimiento.using(:data_warehouse).all.empty?
  end
  
  def index
    @hard_mtto_data = Hardware_mantenimiento.using(:data_warehouse).all
  end

  def export_to_sql
    Hardware_mantenimiento.using(:data_warehouse_final).delete_all if !Hardware_mantenimiento.using(:data_warehouse_final).all.empty?

    manteni = Hardware_mantenimiento.using(:data_warehouse).all
    manteni.each do |data|
      Hardware_mantenimiento.using(:data_warehouse_final).create(Id_Tipo_Mtto: data.Id_Tipo_Mtto,
        Fecha_Mtto: data.Fecha_Mtto, Diagnostico: data.Diagnostico, 
        No_Tecnico: data.No_Tecnico, id_Hardware: data.id_Hardware)
    end
  end
  
  def data 
    manteni = Hardware_mantenimiento.using(:data_warehouse).all
  end

  private

  def export
    Hardware_mantenimiento.using(:data_warehouse).delete_all if !Hardware_mantenimiento.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @hard_mtto_b = @biblio.sheet("Hardware-Mantenimiento")

    @hard_mtto_b.each_row_streaming(offset: 1) do |hard_mtto|
      hard_mtto_new = Hardware_mantenimiento.using(:data_warehouse).new
      hard_mtto_new.Id_Tipo_Mtto = hard_mtto[0].value
      hard_mtto_new.Fecha_Mtto = hard_mtto[1].value
      hard_mtto_new.Diagnostico = hard_mtto[2]
      hard_mtto_new.No_Tecnico = hard_mtto[3].value
      hard_mtto_new.id_Hardware = hard_mtto[4]
      hard_mtto_new.save!
    end
  end
end
