class CarreraController < ApplicationController
  def index
    @carreras = Carrera.using(:controlA).all
  end
end
