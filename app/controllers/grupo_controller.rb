class GrupoController < ApplicationController
  def index  
    @grupos_data = Grupo.using(:data_warehouse).all
    export
  end

  def edit
    @grupo = Grupo.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorClave
  end

  def update
    @grupo = Grupo.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @error = @grupo.errorClave
    if @grupo.update_attributes({Id_Grupo: params[:grupo][:Id_Grupo], Id_Materia: params[:grupo][:Id_Materia], Id_hora: params[:grupo][:Id_hora], Id_Maestro: params[:grupo][:Id_Maestro], Id_Periodo: params[:grupo][:Id_Periodo], Id_Aula: params[:grupo][:Id_Aula], Clave: params[:grupo][:Clave], errorClave: nil})
      redirect_to "/" 
    else
      render :edit
    end
  end

  def destroy
    @grupo = Grupo.using(:data_warehouse).find_by(Id_Grupo: params[:id])
    @grupo.destroy
    redirect_to "/", notice: "Registro borrado con éxito"
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
