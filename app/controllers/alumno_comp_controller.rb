class AlumnoCompController < ApplicationController
  def index
    @alumComp = Alumno_comp.using(:controlA).all
  end
end
