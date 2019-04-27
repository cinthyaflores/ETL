# frozen_string_literal: true

class TipoContratoController < ApplicationController
  def index
    @contrato_data = Tipo_contrato.using(:data_warehouse).all
    export
  end

  private

    def export
      Tipo_contrato.using(:data_warehouse).delete_all if !Tipo_contrato.using(:data_warehouse).all.empty?

      @contrato_ca = Tipo_contrato.using(:controlA).all

      @contrato_ca.each do |cont|
        cont_new = Tipo_contrato.using(:data_warehouse).new
        cont_new.Id_contrato = cont.Id_contrato
        cont_new.Nombre = cont.Nombre
        cont_new.Duración = cont.Duración
        cont_new.save!
      end
    end
end
