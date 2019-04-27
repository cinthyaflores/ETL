# frozen_string_literal: true

class TipoConstanciaController < ApplicationController
  def index
    @constancia_data = Tipo_constancia.using(:data_warehouse).all
    export
  end

  private

    def export
      Tipo_constancia.using(:data_warehouse).delete_all if !Tipo_constancia.using(:data_warehouse).all.empty?

      @constancia_ca = Tipo_constancia.using(:controlA).all

      @constancia_ca.each do |const|
        const_new = Tipo_constancia.using(:data_warehouse).new
        const_new.Id_Tipo_con = const.Id_Tipo_con
        const_new.Nombre = const.Nombre
        const_new.Costo = const.Costo
        const_new.save!
      end
    end
end
