# frozen_string_literal: true

class TituladoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Titulado.using(:data_warehouse).all.empty?
  end

  def init
    export
  end
  
  def empty
    return Titulado.using(:data_warehouse).all.empty?
  end

  def index
    @titulado_data = Titulado.using(:data_warehouse).all
  end

  def export_to_sql
    Titulado.using(:data_warehouse_final).delete_all if !Titulado.using(:data_warehouse_final).all.empty?

    titulado = Titulado.using(:data_warehouse).all
    titulado.each do |data|
      Titulado.using(:data_warehouse_final).create(Id_Titulado: data.Id_Titulado,
        Id_Alumno: data.Id_Alumno, Id_Form_Titu: data.Id_Form_Titu, 
        Fecha_Tit: data.Fecha_Tit)
    end
  end
  
  def data 
    titulado = Titulado.using(:data_warehouse).all
  end

  private

    def export
      Titulado.using(:data_warehouse).delete_all if !Titulado.using(:data_warehouse).all.empty?

      @titulado_ca = Titulado.using(:controlA).all

      @titulado_ca.each do |titulado|
        titulado_new = Titulado.using(:data_warehouse).new
        titulado_new.Id_Titulado = titulado.Id_Titulado
        titulado_new.Id_Alumno = titulado.Id_Alumno
        titulado_new.Id_Form_Titu = titulado.Id_Form_Titu
        titulado_new.Fecha_Tit = titulado.Fecha_Tit
        titulado_new.save!
      end
    end
end
