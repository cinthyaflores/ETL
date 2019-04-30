# frozen_string_literal: true

class AreaMaestroController < ApplicationController
  def index
    @area_maestro_data = Area_maestro.using(:data_warehouse).all
    export
  end

  def edit 
    @area_maestro = Area_maestro.using(:data_warehouse).find_by(Id_Area_mtro: params[:id])
    @error = @area_maestro.errorNombre
  end

  def update 
    @area_maestro = Area_maestro.using(:data_warehouse).find_by(Id_Area_mtro: params[:id])
    @error = @area_maestro.errorNombre
    usuario = current_user.email
    fecha = DateTime.now
    campo_modificado = "Area_Maestro: Nombre" if @error != nil

    if @area_maestro.update_attributes(Nombre: params[:area_maestro][:Nombre], errorNombre: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/"
    else
      render :edit
    end
  
  end

  def destroy 
    @area_maestro = Area_maestro.using(:data_warehouse).find_by(Id_Area_mtro: params[:id])
    @area_maestro.destroy
    redirect_to "/"
  end

  def delete_table 
    Area_maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Area_maestro.using(:data_warehouse).where(errorNombre: 2).destroy_all
    redirect_to "/"
  end

  private

    def export
      Area_maestro.using(:data_warehouse).delete_all if !Area_maestro.using(:data_warehouse).all.empty?

      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @area_maestro_bi = @biblio.sheet("Areas_Maestros")
      @area_maestro_ca = Area_maestro.using(:controlA).all

      @area_maestro_ca.each do |area|
        area_new = Area_maestro.using(:data_warehouse).new
        area_new.Id_Area_mtro = area.Id_Area_mtro
        area_new.Nombre = area.Nombre
        if validate_name(area_new.Nombre)
          area_new.errorNombre = 1 # Error 1 = Control Academico
        end
        area_new.Descripción = area.Descripcion
        area_new.save!
      end

      @area_maestro_bi.each_row_streaming(offset: 1) do |area_b| # Ingresar los que no existen en Control Academico
        if @area_maestro_data.exists?(Id_Area_mtro: area_b[0].value) == false
          area_new = Area_maestro.using(:data_warehouse).new
          area_new.Id_Area_mtro = area_b[0].value
          area_new.Nombre = area_b[1]
          if validate_name(area_new.Nombre)
            area_new.errorNombre = 2 # error 2 = Biblioteca
          end
          area_new.save!
        end
      end

    end
end
