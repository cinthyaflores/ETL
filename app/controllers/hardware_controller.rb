class HardwareController < ApplicationController
  def index
    @hardware_data = Hardware.using(:data_warehouse).all
    export
  end

  private

  def export
    Hardware.using(:data_warehouse).delete_all if !Hardware.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @hardware_b = @biblio.sheet("Hardware")

    @hardware_b.each_row_streaming(offset: 1) do |hardware|
      hardware_new = Hardware.using(:data_warehouse).new
      hardware_new.idHardware = hardware[0]
      hardware_new.fabricante = hardware[1]
      hardware_new.modelo = hardware[2]
      hardware_new.tipo_Hardware = hardware[3]
      hardware_new.f_ingreso = hardware[4].value
      hardware_new.save!
    end
  end
end
