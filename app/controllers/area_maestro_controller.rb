# frozen_string_literal: true

class AreaMaestroController < ApplicationController

  def init
    export
  end
  
  def empty
    return Area_maestro.using(:data_warehouse).all.empty?
  end

  def index
    @area_maestro_data = Area_maestro.using(:data_warehouse).all
  end

  def edit 
    @area_maestro = Area_maestro.using(:data_warehouse).find_by(Id_Area_mtro: params[:id])
    @error = @area_maestro.errorNombre
  end

  def update 
    @area_maestro = Area_maestro.using(:data_warehouse).find_by(Id_Area_mtro: params[:id])
    @error = @area_maestro.errorNombre
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó Area Maestro ID #{params[:id]}: Nombre" if @error != nil

    if @area_maestro.update_attributes(Nombre: params[:area_maestro][:Nombre], errorNombre: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/area_maestro"
    else
      render :edit
    end
  
  end

  def destroy 
    @area_maestro = Area_maestro.using(:data_warehouse).find_by(Id_Area_mtro: params[:id])
    @area_maestro.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Área Maestro ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/area_maestro"
  end

  def delete_table(c_email=current_user.email)
    Area_maestro.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Area_maestro.using(:data_warehouse).where(errorNombre: 2).destroy_all
    usuario = c_email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Area Maestro"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @area_maestro_data = Area_maestro.using(:data_warehouse).all
    case c_user
    when 1
      @area_maestro_data.each do |area|
        if area.errorNombre 
          return true
        end
      end
    when 2
      @area_maestro_data.each do |area|
        if area.errorNombre == 1
          return true
        end
      end
    when 4
      @area_maestro_data.each do |area|
        if area.errorNombre == 2
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Area_maestro.using(:data_warehouse_final).delete_all if !Area_maestro.using(:data_warehouse_final).all.empty?

    areas = Area_maestro.using(:data_warehouse).all
    Area_maestro.using(:data_warehouse_final).new
    areas.each do |data|
      Area_maestro.using(:data_warehouse_final).create(Id_Area_mtro: data.Id_Area_mtro,
        Nombre: data.Nombre, Descripción: data.Descripción)
    end
  end
  
  def data 
    areas = Area_maestro.using(:data_warehouse).all
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

      @area_maestro_data = Area_maestro.using(:data_warehouse).all
      @area_maestro_bi.each_row_streaming(offset: 1) do |area_b| 
        # Ingresar los que no existen en Control Academico
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
