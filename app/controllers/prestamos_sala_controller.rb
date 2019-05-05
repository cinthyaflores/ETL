class PrestamosSalaController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Prestamos_sala.using(:data_warehouse).all.empty?
  end

  def index
    @prestamos_data = Prestamos_sala.using(:data_warehouse).all
  end

  def export_to_sql
    Prestamos_sala.using(:data_warehouse_final).delete_all if !Prestamos_sala.using(:data_warehouse_final).all.empty?

    prestamos = Prestamos_sala.using(:data_warehouse).all
    Prestamos_sala.using(:data_warehouse_final).new
    prestamos.each do |data|
      Prestamos_sala.using(:data_warehouse_final).create(id_Prestamo_Sala: data.id_Prestamo_Sala,
        Fecha: data.Fecha, Hora_Entrada: data.Hora_Entrada, 
        Hora_Salida: data.Hora_Salida, id_Sala: data.id_Sala,Id_Solicitante: data.Id_Solicitante,
        Tipo_Solicitante: data.Tipo_Solicitante, id_Empleado: data.id_Empleado)
    end
  end
  
  def data 
    prestamos = Prestamos_sala.using(:data_warehouse).all
  end

  private

  def export
    Prestamos_sala.using(:data_warehouse).delete_all if !Prestamos_sala.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @prestamos_b = @biblio.sheet("Prestamos_Sala")

    @prestamos_b.each_row_streaming(offset: 1) do |prestamo|
      prestamo_new = Prestamos_sala.using(:data_warehouse).new
      prestamo_new.id_Prestamo_Sala = prestamo[0]
      prestamo_new.Fecha = prestamo[1].value
      prestamo_new.Hora_Entrada = prestamo[2].to_s.match(/[0-9]{1,2}:[0-9][0-9]:[0-9][0-9]/)
      prestamo_new.Hora_Salida = prestamo[3].to_s.match(/[0-9]{1,2}:[0-9][0-9]:[0-9][0-9]/)
      prestamo_new.id_Sala = prestamo[4].value
      prestamo_new.Id_Solicitante = prestamo[5].value
      prestamo_new.Tipo_Solicitante = prestamo[6].value
      prestamo_new.id_Empleado = prestamo[7].value
      prestamo_new.save!
    end
  end
end
