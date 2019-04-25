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

  def validate_name (name)
    !!(name =~ /\d+/) #Validar si el nombre tiene numeros. Convertir a boolean
  end

  def validate_number (num) #Validar números telefónicos (10 digitos)
    !!(num =~ /^\d{10}$/)
  end

  def validate_curp (curp)
    !!(curp =~ /^[A-Z]{4}+\d{6}+[A-Z]{6}+\d{2}$/)
  end

  def validate_weight(peso)
    !!(peso.to_s =~ /^\d+/) #Debe de tener puros numeros
  end

end
