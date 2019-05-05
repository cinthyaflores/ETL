# frozen_string_literal: true

class PersonalAdminController < ApplicationController
  def init
    export
  end

  def empty
    return Personal_Admin.using(:data_warehouse).all.empty?
  end

  def index
    @pers_admin_data = Personal_Admin.using(:data_warehouse).all
  end

  def edit
    @personal = Personal_Admin.using(:data_warehouse).find_by(Id_Pers: params[:id])
    @errores = [@personal.errorNombre, @personal.errorEstado]
  end

  def update
    @personal = Personal_Admin.using(:data_warehouse).find_by(Id_Pers: params[:id])
    @errores = [@personal.errorNombre, @personal.errorEstado]

    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Personal Admin ID: #{params[:id]}" 

    if @personal.update_attributes(Nombre: params[:personal_admin][:Nombre], Estado: params[:personal_admin][:Estado], errorNombre: nil, errorEstado: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/personal_admin"
    else
      render :edit
    end
  end

  def destroy
    @personal = Personal_Admin.using(:data_warehouse).find_by(Id_Pers: params[:id])
    @personal.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Personal Admin ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/personal_admin"
  end
  
  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Personal Admin"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Personal_Admin.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Personal_Admin.using(:data_warehouse).where(errorEstado: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @pers_admin_data = Personal_Admin.using(:data_warehouse).all
    case c_user
    when 1
      @pers_admin_data.each do |perso|
        if perso.errorNombre || perso.errorEstado
          return true
        end
      end
    when 2
      @pers_admin_data.each do |perso|
        if perso.errorNombre || perso.errorEstado
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Personal_Admin.using(:data_warehouse_final).delete_all if !Personal_Admin.using(:data_warehouse_final).all.empty?

    personal = Personal_Admin.using(:data_warehouse).all
    Personal_Admin.using(:data_warehouse_final).new
    personal.each do |data|
      Personal_Admin.using(:data_warehouse_final).create(Id_Pers: data.Id_Pers,
        Id_Area: data.Id_Area, Nombre: data.Nombre,CorreoE: data.CorreoE,
        Fecha_Cont: data.Fecha_Cont, Estado: data.Estado)
    end
  end
  
  def data 
    actividades = Personal_Admin.using(:data_warehouse).all
  end

  private

    def export
      Personal_Admin.using(:data_warehouse).delete_all if !Personal_Admin.using(:data_warehouse).all.empty?

      @pers_admin_ca = Personal_Admin.using(:controlA).all

      @pers_admin_ca.each do |personal|
        personal_new = Personal_Admin.using(:data_warehouse).new
        if validate_name(personal.Nombre)
          personal_new.errorNombre = 1
        end
        if !validate_estado(personal.Estado)
          personal_new.errorEstado = 1
        end
        personal_new.Id_Pers = personal.Id_Pers
        personal_new.Id_Area = personal.Id_Area
        personal_new.Nombre = personal.Nombre
        personal_new.CorreoE = personal.CorreoE
        personal_new.Fecha_Cont = personal.Fecha_Cont
        personal_new.Estado = personal.Estado
        personal_new.save!
      end
    end
end
