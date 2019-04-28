# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require "roo"
  before_action :import_excel
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  private

    # PARA AGREGAR MÁS DATOS AL INICIO DE SESION DE DEVISE (solo se ponen los datos extras)
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:tipo])
    end

    def import_excel
      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    end

    def validate_name (name)
      !!(name =~ /\d+/) # Validar si el nombre tiene numeros. Convertir a boolean SOLO LETRAS: /^\D+/
    end

    def validate_number (num) # Validar números telefónicos (10 digitos)
      !!(num =~ /^\d{10}$/)
    end

    def validate_curp (curp)
      !!(curp =~ /^[A-Z]{4}+\d{6}+[A-Z]{6}+\d{2}$/)
    end

    def validate_weight(peso)
      !!(peso.to_s =~ /^\d+/) # Debe de tener puros numeros
    end

    def validate_clave(clave)
      !!(clave =~ /^[A-Z]{2}+\d{4}$/)
    end

    def validate_estado(estado)
      puts
      !!(estado.to_s =~ /[1-2]{1}/)
    end

    def find_id_alumno(no_ctrl)
      data = Alumno.using(:data_warehouse).all
      data.each do |alumno|
        return alumno.Id_Alumno if alumno.No_control == no_ctrl
      end
    end

    def area_maestro(tipo)
      return 10 if tipo == 2
      return 11 if tipo == 1
    end

    def area_maestro_id(clave)
      maestros_data = Maestro.using(:data_warehouse).all
      maestros_data.each do |maestro|
        return maestro.Id_Area_mtro if maestro.Clave == clave
      end
    end

    def find_id_maestro(clave)
      data = Maestro.using(:data_warehouse).all
      data.each do |maestro|
        return maestro.Id_maestro if maestro.Clave == clave
      end
    end

end
