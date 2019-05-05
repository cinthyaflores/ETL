class HardwareController < ApplicationController

  def init
    export
  end
  
  def empty
    return Hardware.using(:data_warehouse).all.empty?
  end

  def index
    @hardware_data = Hardware.using(:data_warehouse).all
  end

  def export_to_sql
    Hardware.using(:data_warehouse_final).delete_all if !Hardware.using(:data_warehouse_final).all.empty?

    hardware = Hardware.using(:data_warehouse).all
    hardware.each do |data|
      Hardware.using(:data_warehouse_final).create(
        idHardware: data.idHardware, fabricante: data.fabricante, 
        modelo: data.modelo, tipo_Hardware: data.tipo_Hardware, f_ingreso: data.f_ingreso)
    end
  end
  
  def data 
    hardware = Hardware.using(:data_warehouse).all
  end

  private

  def export
    Hardware.using(:data_warehouse).delete_all if !Hardware.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @hardware_b = @biblio.sheet("Hardware")

    @hardware_b.each_row_streaming(offset: 1) do |hardware|
      hardware_new = Hardware.using(:data_warehouse).new
      hardware_new.idHardware = hardware[0].value
      hardware_new.fabricante = hardware[1].value
      hardware_new.modelo = hardware[2].value
      hardware_new.tipo_Hardware = hardware[3].value
      hardware_new.f_ingreso = hardware[4].value
      hardware_new.save!
    end
  end
end
