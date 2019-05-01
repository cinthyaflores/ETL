# frozen_string_literal: true

class MaestrosController < ApplicationController

  def init
    export
  end

  def empty
    return Alumno.using(:data_warehouse).all.empty?
  end

  def index
    @maestrosData = Maestro.using(:data_warehouse).all
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
    redirect_to "/maestros"
  end

  def delete_table
    Maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Maestro.using(:data_warehouse).where(errorTelefono: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @maestrosData = Maestro.using(:data_warehouse).all
    case c_user
    when 1
      @maestrosData.each do |maestro|
        if maestro.errorNombre || maestro.errorTelefono
          @errores = true
          return true
        end
      end
    when 2
      @maestrosData.each do |maestro|
        if (maestro.errorNombre || maestro.errorTelefono) && maestro.base == "c"
          @errores = true
          return true
        end
      end
    when 3
      @maestrosData.each do |maestro|
        if (maestro.errorNombre || maestro.errorTelefono) && maestro.base == "e"
          @errores = true
          return true
        end
      end
    when 4
      @maestrosData.each do |maestro|
        if (maestro.errorNombre || maestro.errorTelefono) && maestro.base == "b"
          @errores = true
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Maestro.using(:data_warehouse_final).destroy_all
    maestros_bien = Maestro.using(:data_warehouse).all.order(:Id_maestro)
    maestros_bien.each do |data|
      Maestro.using(:data_warehouse_final).create(Id_maestro: data.Id_maestro, Id_Area_mtro: data.Id_Area_mtro, Id_contrato: data.Id_contrato, Nombre: data.Nombre, CorreoElec: data.CorreoElec, Telefono: data.Telefono, Titulo: data.Titulo, Clave: data.Clave)
    end
  end
  
  def data 
    maestros_bien = Maestro.using(:data_warehouse).all.order(:Id_maestro)
  end

  private

    def export
      Maestro.using(:data_warehouse).destroy_all
      id_m = 0

      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @maestrosB = @biblio.sheet("Maestros")
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

      @maestrosData = Maestro.using(:data_warehouse).all
      @maestrosB.each_row_streaming(offset: 1) do |maestroB| # Ingresar los que no existen en Control Academico
        if @maestrosData.exists?(Id_maestro: maestroB[0].value) == false
          maestroNew = Maestro.using(:data_warehouse).new
          maestroNew.Id_maestro = maestroB[0].value
          maestroNew.Id_Area_mtro = maestroB[1].value
          maestroNew.base = "b"
          maestroNew.save!
        end
      end

    end

end
