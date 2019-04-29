# frozen_string_literal: true

class MovilidadController < ApplicationController
  def init
    export
  end

  def index
    @movilidad_data = Movilidad.using(:data_warehouse).all
    verify
  end

  def edit
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @errores = [@movilidad.errorPais, @movilidad.errorEstado]
  end

  def update
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @errores = [@movilidad.errorPais, @movilidad.errorEstado]

    if @movilidad.update_attributes(País: params[:movilidad][:País], Estado: params[:movilidad][:Estado], errorPais: nil, errorEstado: nil)
      redirect_to "/movilidad"
    else
      render :edit
    end
  end

  def destroy
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @movilidad.destroy
    redirect_to "/movilidad"
  end

  def delete_table
    Movilidad.using(:data_warehouse).where(errorPais: 1).destroy_all
    Movilidad.using(:data_warehouse).where(errorEstado: 1).destroy_all
    redirect_to "/movilidad"
  end

  private

    def verify
      @movilidad_data.each do |mov|
        if mov.errorPais || mov.errorEstado
          @errores = true
        end
      end
    end

    def export
      Movilidad.using(:data_warehouse).delete_all if !Movilidad.using(:data_warehouse).all.empty?

      @movilidad_ca = Movilidad.using(:controlA).all

      @movilidad_ca.each do |movi|
        movi_new = Movilidad.using(:data_warehouse).new
        if validate_name(movi.País)
          movi_new.errorPais = 1
        end
        if validate_name(movi.Estado)
          movi_new.errorEstado = 1
        end
        movi_new.Id_Movilidad = movi.Id_Movilidad
        movi_new.Id_Carrera = movi.Id_Carrera
        movi_new.País = movi.País
        movi_new.Estado = movi.Estado
        movi_new.Universidad = movi.Universidad
        movi_new.save!
      end
    end
end
