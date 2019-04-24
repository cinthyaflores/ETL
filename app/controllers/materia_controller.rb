class MateriaController < ApplicationController
  def index
    @materias = Materia.using(:controlA).all
  end
end
