# frozen_string_literal: true

class GrupoActividadController < ApplicationController
  def init
    export
  end

  def index
    @grupos_data = Grupo_actividad.using(:data_warehouse).all
    verify
  end

  def edit
    grupo = Grupo_actividad.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorCupo
  end

  def update
    grupo = Grupo_actividad.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorCupo

    if grupo.update_attributes(Cupo: params[:grupo_actividad][:Cupo], errorCupo: nil)
      redirect_to "/grupo_actividad"
    else
      render :edit
    end
  end

  def destroy
    grupo = Grupo_actividad.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    grupo.destroy
    redirect_to "/grupo_actividad"
  end

  private
  
    def verify
      @grupos_data.each do |grupo|
        if grupo.errorCupo
          @errores = true
        end
      end
    end

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
        grupo.Hora_inicio = grupo_e.Hora_inicio
        grupo.Hora_fin = grupo_e.Hora_fin
        grupo.save!
      end
    end
    
end
