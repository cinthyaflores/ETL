# frozen_string_literal: true

class AdminUserController < ApplicationController
  def init
    AlumnosController.new.init #LO INICIALIZA, PARA QUE EL INDEX SOLO MUESTRE LO QUE TIENE EL DATAWAREHOUSE
    ActividadExtraescolarController.new.index
    AlumnoCompController.new.index
    AlumnoGrupoActividadController.new.index
    MaestrosController.new.index

   
  end

  def errors
    redirect_to '/alumnos'
  end

  def download
    redirect_to '/alumnos'
  end

end
