# frozen_string_literal: true

class TipoContratoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Tipo_contrato.using(:data_warehouse).all.empty?
  end

  def index
    @contrato_data = Tipo_contrato.using(:data_warehouse).all
  end

  def export_to_sql
    Tipo_contrato.using(:data_warehouse_final).delete_all if !Tipo_contrato.using(:data_warehouse_final).all.empty?

    tipo = Tipo_contrato.using(:data_warehouse).all
    Tipo_contrato.using(:data_warehouse_final).new
    tipo.each do |data|
      Tipo_contrato.using(:data_warehouse_final).create(Id_contrato: data.Id_contrato,
        Nombre: data.Nombre, Duración: data.Duración)
    end
  end
  
  def data 
    tipo = Tipo_contrato.using(:data_warehouse).all
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
