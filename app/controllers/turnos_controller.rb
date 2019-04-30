class TurnosController < ApplicationController

  def index
    @turnos_data = Turnos.using(:data_warehouse).all
    export
  end

  private

  def export
    Turnos.using(:data_warehouse).delete_all if !Turnos.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    turnos_biblio = @biblio.sheet("Turnos")

    turnos_biblio.each_row_streaming(offset: 1) do |turno| # Ingresar los que no existen en Control Academico
      turno_new = Turnos.using(:data_warehouse).new
      turno_new.idTurno = turno[0].value
      turno_new.nomb_turno = turno[1].value
      turno_new.hora_inicio = turno[2].to_s.match(/[0-9]{1,2}:[0-9][0-9]:[0-9][0-9]/)
      turno_new.hora_fin = turno[3].to_s.match(/[0-9]{1,2}:[0-9][0-9]:[0-9][0-9]/)
      turno_new.save!
    end
  end

end
