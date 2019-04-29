class PeriodicosController < ApplicationController
  def index
    @periodicos_data = Periodico.using(:data_warehouse).all
    export
  end

  private

  def export
    Periodico.using(:data_warehouse).delete_all if !Periodico.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @periodicos_b = @biblio.sheet("Periodicos")

    @periodicos_b.each_row_streaming(offset: 1) do |periodico|
      periodico_new = Periodico.using(:data_warehouse).new
      periodico_new.idPeriodico = periodico[0]
      periodico_new.No_Serie = periodico[1]
      periodico_new.fecha_publicado = periodico[2].value
      periodico_new.Id_Editorial = periodico[3].value
      periodico_new.save!
    end
  end
end
