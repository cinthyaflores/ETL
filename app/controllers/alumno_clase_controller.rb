class AlumnoClaseController < ApplicationController
  def index
    @alumno_clase = Alumno_clase.using(:controlA).all
  end
end
