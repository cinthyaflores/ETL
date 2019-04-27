# frozen_string_literal: true

class TipoBajaController < ApplicationController
  def index
    @tipo_data = Tipo_baja.using(:data_warehouse).all
    export
  end

  private

    def export
      Tipo_baja.using(:data_warehouse).delete_all if !Tipo_baja.using(:data_warehouse).all.empty?

      @tipo_ca = Tipo_baja.using(:controlA).all

      @tipo_ca.each do |tipo|
        tipo_new = Tipo_baja.using(:data_warehouse).new
        tipo_new.Id_Baja = tipo.Id_Baja
        tipo_new.Nombre = tipo.Nombre
        tipo_new.save!
      end
    end
end
