# frozen_string_literal: true

class CambioCarreraController < ApplicationController

  def init
    export
  end
  
  def empty
    return Cambio_carrera.using(:data_warehouse).all.empty?
  end

  def index
    @cambios_data = Cambio_carrera.using(:data_warehouse).all
  end
  
  def export_to_sql
    Cambio_carrera.using(:data_warehouse_final).delete_all if !Cambio_carrera.using(:data_warehouse_final).all.empty?

    carreras = Cambio_carrera.using(:data_warehouse).all
    carreras.each do |data|
      Cambio_carrera.using(:data_warehouse_final).create(Id_Cambio: data.Id_Cambio,
        Id_Alumno: data.Id_Alumno, Id_Carr_Ant: data.Id_Carr_Ant, 
        Fec_Cambio: data.Fec_Cambio)
    end
  end
  
  def data 
    carreras = Cambio_carrera.using(:data_warehouse).all
  end

  private

    def export
      Cambio_carrera.using(:data_warehouse).delete_all if !Cambio_carrera.using(:data_warehouse).all.empty?

      @cambios_ca = Cambio_carrera.using(:controlA).all

      @cambios_ca.each do |cambio|
        @cambio_new = Cambio_carrera.using(:data_warehouse).new
        @cambio_new.Id_Cambio = cambio.Id_Cambio
        @cambio_new.Id_Alumno = cambio.Id_Alumno
        @cambio_new.Id_Carr_Ant = cambio.Id_Carr_Ant
        @cambio_new.Fec_Cambio = cambio.Fec_Cambio
        @cambio_new.save!
      end
    end
end
