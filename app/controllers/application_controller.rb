class ApplicationController < ActionController::Base
  require 'roo'
  before_action :import_excel
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #PARA AGREGAR MÁS DATOS AL INICIO DE SESION DE DEVISE (solo se ponen los datos extras)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:tipo])
  end

  def import_excel
    @biblio = Roo::Spreadsheet.open('./public/Alumnos.xlsx')
  end 
end
