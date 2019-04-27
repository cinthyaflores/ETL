# frozen_string_literal: true

class PeriodoController < ApplicationController
  def index
    @periodosData = Periodo.using(:data_warehouse).all
    export
  end

  private

    def export
      Periodo.using(:data_warehouse).delete_all if !Periodo.using(:data_warehouse).all.empty?
      last_p = 0
      @periodosCA = Periodo.using(:controlA).all
      @periodosE = Periodo.using(:extra).all

      @periodosCA.each do |periodoCA|
        periodoNew = Periodo.using(:data_warehouse).new
        periodoNew.Id_Periodo = periodoCA.Id_Periodo
        periodoNew.Nombre = periodoCA.Nombre
        periodoNew.FechaIn = periodoCA.FechaIn
        periodoNew.FechaFin = periodoCA.FechaFin
        periodoNew.Abreviacion = periodoCA.Abreviacion
        @periodosE.each do |periodoE|
          # Verificar que el nombre sea el mismo y añadir el campo de Id_periodo_extra a los registros que si están en extraescolares
          if match_period(periodoCA.Nombre, periodoE.Rango_fecha)
            periodoNew.Id_Periodo_Extra = periodoE.Id_periodo_extra
          end
        end
        periodoNew.save!
        last_p = periodoCA.Id_Periodo
      end
    end

    def match_period(periodo1, periodo2)
      true if periodo1.gsub(/\s+/, "") == periodo2.gsub(/\s+/, "")
    end
end
