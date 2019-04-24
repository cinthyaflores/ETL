class UnidadesController < ApplicationController
  def index
    @unidades = Unidad.using(:controlA).all
  end
end
