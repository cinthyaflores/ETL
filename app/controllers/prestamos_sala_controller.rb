class PrestamosSalaController < ApplicationController
  def index
    @prestamos_data = Prestamos_sala.using(:data_warehouse).all
    export
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
