# frozen_string_literal: true

class PersonalAdminController < ApplicationController
  def init
    export
  end

  def index
    @pers_admin_data = Personal_Admin.using(:data_warehouse).all
    verify
  end

  def edit
    @personal = Personal_Admin.using(:data_warehouse).find_by(Id_Pers: params[:id])
    @errores = [@personal.errorNombre, @personal.errorEstado]
  end

  def update
    @personal = Personal_Admin.using(:data_warehouse).find_by(Id_Pers: params[:id])
    @errores = [@personal.errorNombre, @personal.errorEstado]

    if @personal.update_attributes(Nombre: params[:personal_admin][:Nombre], Estado: params[:personal_admin][:Estado], errorNombre: nil, errorEstado: nil)
      redirect_to "/personal_admin"
    else
      render :edit
    end
  end

  def destroy
    @personal = Personal_Admin.using(:data_warehouse).find_by(Id_Pers: params[:id])
    @personal.destroy
    redirect_to "/personal_admin"
  end
  
  private

    def verify
      @pers_admin_data.each do |personal|
        if personal.errorNombre || personal.errorEstado
          @errores = true
        end
      end
    end

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
