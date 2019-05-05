class TurnosController < ApplicationController

  def init
    export
  end
  
  def empty
    return Turnos.using(:data_warehouse).all.empty?
  end

  def index
    @turnos_data = Turnos.using(:data_warehouse).all
  end

  def export_to_sql
    Turnos.using(:data_warehouse_final).delete_all if !Turnos.using(:data_warehouse_final).all.empty?

    turnos = Turnos.using(:data_warehouse).all
    turnos.each do |data|
      Turnos.using(:data_warehouse_final).create(idTurno: data.idTurno,
        nomb_turno: data.nomb_turno, hora_inicio: data.hora_inicio, 
        hora_fin: data.hora_fin)
    end
  end
  
  def data 
    turnos = Turnos.using(:data_warehouse).all
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
