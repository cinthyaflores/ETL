class AulaController < ApplicationController
  def index
    #@excel = @biblio.sheet('alumnos')
    @aulasCA = Aula.using(:controlA).all #CAMPOS: Id_Aula, Nombre, Edificio
    @aulasE= Aula.using(:extra).all #CAMPOS: Id_aula, Nombre, Descripcion
  end
end
