# frozen_string_literal: true

class FormaTitulacionController < ApplicationController

  def init
    export 
  end

  def empty
    return Forma_titulacion.using(:data_warehouse).all.empty?
  end

  def index
    @forma_titu_data = Forma_titulacion.using(:data_warehouse).all
  end

  def export_to_sql
    Forma_titulacion.using(:data_warehouse_final).delete_all if !Forma_titulacion.using(:data_warehouse_final).all.empty?

    actividades = Forma_titulacion.using(:data_warehouse).all
    actividades.each do |data|
      Forma_titulacion.using(:data_warehouse_final).create(
        Id_Form_Titu: data.Id_Form_Titu, Nombre: data.Nombre)
    end
  end
  
  def data 
    actividades = Forma_titulacion.using(:data_warehouse).all
  end

  private

    def export
      Forma_titulacion.using(:data_warehouse).delete_all if !Forma_titulacion.using(:data_warehouse).all.empty?

      @forma_titu_ca = Forma_titulacion.using(:controlA).all

      @forma_titu_ca.each do |forma|
        forma_new = Forma_titulacion.using(:data_warehouse).new
        forma_new.Id_Form_Titu = forma.Id_Form_Titu
        forma_new.Nombre = forma.Nombre
        forma_new.save!
      end
    end
end
