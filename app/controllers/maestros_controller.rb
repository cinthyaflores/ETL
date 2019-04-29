# frozen_string_literal: true

class MaestrosController < ApplicationController
  def init
    export
  end

  def index
    @maestrosData = Maestro.using(:data_warehouse).all
    verify
  end

  def edit
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @errores = [@maestro.errorNombre, @maestro.errorTelefono]
  end

  def update
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @errores = [@maestro.errorNombre, @maestro.errorTelefono]
    if @maestro.update_attributes(Id_maestro: params[:maestro][:Id_maestro], Nombre: params[:maestro][:Nombre], Telefono: params[:maestro][:Telefono], errorNombre: nil, errorTelefono: nil)
      redirect_to "/maestros"
    else
      render :edit
    end
  end

  def destroy
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @maestro.destroy
    redirect_to "/maestros", notice: "Registro borrado con éxito"
  end

  def delete_table
    Maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Maestro.using(:data_warehouse).where(errorTelefono: 1).destroy_all
    redirect_to "/maestros"
  end

  private

    def verify
      @maestrosData.each do |maestro|
        if maestro.errorNombre || maestro.errorTelefono
          @errores = true
        end
      end
    end

    def export
      Maestro.using(:data_warehouse).destroy_all
      id_m = 0
      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @excel = @biblio.sheet("Maestros")
      @maestrosCA = Maestro.using(:controlA).all
      @maestrosE = Maestro.using(:extra).all

      @maestrosCA.each do |maestroCA|
        maestroNew = Maestro.using(:data_warehouse).new
        if validate_name(maestroCA.Nombre)
          maestroNew.errorNombre = 1
        end
        if !validate_number(maestroCA.Telefono)
          maestroNew.errorTelefono = 1
        end
        id_m += 1
        maestroNew.Id_maestro = maestroCA.Id_maestro
        maestroNew.Id_Area_mtro = maestroCA.Id_Area_mtro
        maestroNew.Id_contrato = maestroCA.Id_contrato
        maestroNew.Nombre = maestroCA.Nombre
        maestroNew.CorreoElec = maestroCA.CorreoElec
        maestroNew.Telefono = maestroCA.Telefono
        maestroNew.Titulo = maestroCA.Titulo
        maestroNew.base = "c"
        maestroNew.save!
      end

      @maestrosE.each do |maestroE|
        maestroNew = Maestro.using(:data_warehouse).new
        if validate_name(maestroE.Nombre)
          maestroNew.errorNombre = 1
        end
        if !validate_number(maestroE.Telefono)
          maestroNew.errorTelefono = 1
        end
        id_m += 1
        maestroNew.Id_maestro = id_m
        maestroNew.Id_Area_mtro = area_maestro(maestroE.TipoMaestro)
        maestroNew.Clave = maestroE.Id_maestro_extra
        maestroNew.Nombre = maestroE.Nombre
        maestroNew.CorreoElec = maestroE.Correo
        maestroNew.Telefono = maestroE.Telefono
        maestroNew.base = "e"
        maestroNew.save!
      end
    end
end
