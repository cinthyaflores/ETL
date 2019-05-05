# frozen_string_literal: true

class GrupoActividadController < ApplicationController
  def init
    export
  end

  def empty
    return Grupo_actividad.using(:data_warehouse).all.empty?
  end

  def index
    @grupos_data = Grupo_actividad.using(:data_warehouse).all
    export
  end

  def edit
    @grupo = Grupo_actividad.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorCupo
  end

  def update
    @grupo = Grupo_actividad.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorCupo
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo = "Actualizó Grupo Act ID #{params[:id]}: Cupo"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)

    if @grupo.update_attributes(Cupo: params[:grupo_actividad][:Cupo], errorCupo: nil)
      redirect_to "/grupo_actividad"
    else
      render :edit
    end
  end

  def destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo = "Eliminó el registro Grupo Act ID #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)
    @grupo = Grupo_actividad.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @grupo.destroy
    redirect_to "/grupo_actividad"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo = "Eliminó los registros de la tabla Grupo Act."
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)
    Grupo_actividad.using(:data_warehouse).where(errorCupo: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @grupos_data = Grupo_actividad.using(:data_warehouse).all
    case c_user
    when 1
      @grupos_data.each do |grupo|
        if grupo.errorCupo
          return true
        end
      end
    when 3
      @grupos_data.each do |grupo|
        if grupo.errorCupo
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Grupo_actividad.using(:data_warehouse_final).delete_all if !Grupo_actividad.using(:data_warehouse_final).all.empty?

    grupo_act = Grupo_actividad.using(:data_warehouse).all
    Grupo_actividad.using(:data_warehouse_final).new
    grupo_act.each do |data|
      Grupo_actividad.using(:data_warehouse_final).create(Id_Grupo: data.Id_Grupo,
        Id_actividad: data.Id_actividad, Nombre: data.Nombre,Cupo: data.Cupo,
        Id_area: data.Id_area, Dias: data.Dias,Hora_inicio: data.Hora_inicio,Hora_fin: data.Hora_fin)
    end
  end
  
  def data 
    grupo_act = Grupo_actividad.using(:data_warehouse).all
  end

  private

    def export
      Grupo_actividad.using(:data_warehouse).delete_all if !Grupo_actividad.using(:data_warehouse).all.empty?

      grupo_extra = Grupo_actividad.using(:extra).all 

      grupo_extra.each do |grupo_e|
        grupo = Grupo_actividad.using(:data_warehouse).new
        if !validate_weight(grupo_e.Cupo)
          grupo.errorCupo = 1
        end
        grupo.Id_Grupo = grupo_e.Id_Grupo
        grupo.Id_actividad = grupo_e.Id_actividad_e
        grupo.Nombre = grupo_e.Nombre
        grupo.Cupo = grupo_e.Cupo
        grupo.Id_area = grupo_e.Id_area
        grupo.Dias = grupo_e.Dias
        grupo.Hora_inicio = grupo_e.Hora_inicio.to_s
        grupo.Hora_fin = grupo_e.Hora_fin.to_s
        grupo.save!
      end
    end
    
end
