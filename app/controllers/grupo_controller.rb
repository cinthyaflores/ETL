# frozen_string_literal: true

class GrupoController < ApplicationController
  def init
    export
  end

  def empty
    return Grupo.using(:data_warehouse).all.empty?
  end

  def index
    @grupos_data = Grupo.using(:data_warehouse).all
  end

  def edit
    @grupo = Grupo.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorClave
  end

  def update
    @grupo = Grupo.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorClave
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Grupos ID #{params[:id]}: #{@grupo.Clave} --> #{params[:grupo][:Clave]}" if @error != nil

    if @grupo.update_attributes(Id_Grupo: params[:grupo][:Id_Grupo], Id_Materia: params[:grupo][:Id_Materia], Id_hora: params[:grupo][:Id_hora], Id_Maestro: params[:grupo][:Id_Maestro], Id_Periodo: params[:grupo][:Id_Periodo], Id_Aula: params[:grupo][:Id_Aula], Clave: params[:grupo][:Clave], errorClave: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/grupo"
    else
      render :edit
    end
  end

  def destroy
    @grupo = Grupo.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @grupo.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Grupo ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)

    redirect_to "/grupo", notice: "Registro borrado con éxito" #APARECE ARRIBA 
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Grupo"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Grupo.using(:data_warehouse).where(errorClave: 1).destroy_all
    redirect_to "/grupo"
  end

  def verify(c_user)
    @grupos_data = Grupo.using(:data_warehouse).all
    case c_user
    when 1
      @grupos_data.each do |grupo|
        if grupo.errorClave
          return true
        end
      end
    when 2
      @grupos_data.each do |grupo|
        if grupo.errorClave
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Grupo.using(:data_warehouse_final).delete_all if !Grupo.using(:data_warehouse_final).all.empty?

    grupo = Grupo.using(:data_warehouse).all
    Grupo.using(:data_warehouse_final).new
    grupo.each do |data|
      Grupo.using(:data_warehouse_final).create(Id_Grupo: data.Id_Grupo,
                                                Id_Materia: data.Id_Materia, Id_hora: data.Id_hora,
                                                Id_Maestro: data.Id_Maestro, Id_Periodo: data.Id_Periodo,
                                                Id_Aula: data.Id_Aula, Clave: data.Clave)
    end
  end

  def data
    actividades = Grupo.using(:data_warehouse).all
  end

  private

    def export
      Grupo.using(:data_warehouse).destroy_all

      @grupos_ca = Grupo.using(:controlA).all

      @grupos_ca.each do |grupo|
        grupo_new = Grupo.using(:data_warehouse).new
        if !validate_clave(grupo.Clave)
          grupo_new.errorClave = 1
        end
        grupo_new.Id_Grupo = grupo.Id_Grupo
        grupo_new.Id_Materia = grupo.Id_Materia
        grupo_new.Id_hora = grupo.Id_hora
        grupo_new.Id_Maestro = grupo.Id_maestro
        grupo_new.Id_Periodo = grupo.Id_Periodo
        grupo_new.Id_Aula = grupo.Id_Aula
        grupo_new.Clave = grupo.Clave
        grupo_new.save!
      end
    end
end
