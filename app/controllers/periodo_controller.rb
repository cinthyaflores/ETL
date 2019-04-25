class PeriodoController < ApplicationController
  def index
    #@excel = @biblio.sheet('alumnos')
    @periodosCA = Periodo.using(:controlA).all #CAMPOS: Id_Periodo, Nombre, FechaIn, FechaFin, Abreviacion
    @periodosE= Periodo.using(:extra).all #CAMPOS: Id_periodo, Rango_fecha, Nombre
  end
end
