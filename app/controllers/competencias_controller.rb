class CompetenciasController < ApplicationController
  def index
    @competencias = Competencia.using(:controlA).all
  end
end
