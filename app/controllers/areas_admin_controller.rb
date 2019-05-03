# frozen_string_literal: true

class AreasAdminController < ApplicationController

  def init
    export 
  end

  def empty
    return Areas_admin.using(:data_warehouse).all.empty?
  end

  def index
    @areas_admin_data = Areas_admin.using(:data_warehouse).all
  end

  def edit 
    @areas = Areas_admin.using(:data_warehouse).find_by(Id_Area: params[:id])
  end

  def update 
    @areas = Areas_admin.using(:data_warehouse).find_by(Id_Area: params[:id])
    @error = @areas.errorNombre
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Areas_admin ID #{params[:id]}: #{@areas.Nombre} --> #{params[:areas_admin][:Nombre]}" if @error != nil

    if @areas.update_attributes(Nombre: params[:areas_admin][:Nombre], errorNombre: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/areas_admin"
    else
      render :edit
    end
  end

  def destroy 
    @areas = Areas_admin.using(:data_warehouse).find_by(Id_Area: params[:id])
    @areas.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Areas_admin ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/areas_admin"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Areas_admin"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Areas_admin.using(:data_warehouse).where(errorNombre: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @Areas_admin_data = Areas_admin.using(:data_warehouse).all
    case c_user
    when 1
      @Areas_admin_data.each do |areas|
        if areas.errorNombre
          return true
        end
      end
    when 2
      @Areas_admin_data.each do |areas|
        if areas.errorNombre
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Areas_admin.using(:data_warehouse_final).delete_all if !Areas_admin.using(:data_warehouse_final).all.empty?

    areas = Areas_admin.using(:data_warehouse).all
    Areas_admin.using(:data_warehouse_final).new
    areas.each do |data|
      Areas_admin.using(:data_warehouse_final).create(Id_Area: data.Id_Area,
      Nombre: data.Nombre, Descr: data.Descr)
    end
  end
  
  def data 
    areas = Areas_admin.using(:data_warehouse).all
  end

  private

    def export
      Areas_admin.using(:data_warehouse).delete_all if !Areas_admin.using(:data_warehouse).all.empty?

      @areas_admin_ca = Areas_admin.using(:controlA).all

      Areas_admin.using(:data_warehouse).new
      @areas_admin_ca.each do |area|
        area_admin_new = Areas_admin.using(:data_warehouse).new
        area_admin_new.Id_Area = area.Id_Area
        area_admin_new.Nombre = area.Nombre
        area_admin_new.Descr = area.Descr
        if validate_name(area.Nombre)
          area_admin_new.errorNombre = 1
        end
        area_admin_new.save!
      end
    end
end
