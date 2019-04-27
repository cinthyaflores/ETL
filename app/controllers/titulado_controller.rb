# frozen_string_literal: true

class TituladoController < ApplicationController
  def index
    @titulado_data = Titulado.using(:data_warehouse).all
    export
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
