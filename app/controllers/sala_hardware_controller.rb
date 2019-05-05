class SalaHardwareController < ApplicationController

  def init
    export
  end
  
  def empty
    return Sala_hardware.using(:data_warehouse).all.empty?
  end

  def index
    @sala_hard_data = Sala_hardware.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Sala_hardware.using(:data_warehouse_final).delete_all if !Sala_hardware.using(:data_warehouse_final).all.empty?

    salas = Sala_hardware.using(:data_warehouse).all
    salas.each do |data|
      Sala_hardware.using(:data_warehouse_final).create(
        Id_salon: data.Id_salon, Id_Hardware: data.Id_Hardware, 
        Cantidad: data.Cantidad)
    end
  end
  
  def data 
    salas = Sala_hardware.using(:data_warehouse).all
  end

  private

  def export
    Sala_hardware.using(:data_warehouse).delete_all if !Sala_hardware.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @sala_hard_b = @biblio.sheet("Sala_Hardware")

    @sala_hard_b.each_row_streaming(offset: 1) do |sala_hard|
      sala_hard_new = Sala_hardware.using(:data_warehouse).new
      sala_hard_new.Id_salon= sala_hard[0].value
      sala_hard_new.Id_Hardware = sala_hard[1]
      sala_hard_new.Cantidad = sala_hard[2].value
      sala_hard_new.save!
    end
  end
end
