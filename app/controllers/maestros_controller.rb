class MaestrosController < ApplicationController

  def index  
    @maestrosData = Maestro.using(:data_warehouse).all
    export
  end

  def edit
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @errores = [@maestro.errorNombre, @maestro.errorTelefono]
  end

  def update
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @errores = [@maestro.errorNombre, @maestro.errorTelefono]
    if @maestro.update_attributes({Id_maestro: params[:maestro][:Id_maestro], Nombre: params[:maestro][:Nombre], Telefono: params[:maestro][:Telefono], errorNombre: nil, errorTelefono: nil})
      redirect_to "/" 
    else
      render :edit
    end
  end

  def destroy
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @maestro.destroy
    redirect_to "/", notice: "Registro borrado con éxito"
  end

  private

  def export
    Maestro.using(:data_warehouse).destroy_all
    id_m=0
    @excel = @biblio.sheet('Maestros')
    @maestrosCA = Maestro.using(:controlA).all 
    @maestrosE= Maestro.using(:extra).all 

    @maestrosCA.each do |maestroCA|
      maestroNew = Maestro.using(:data_warehouse).new
      if validate_name(maestroCA.Nombre)
        errorNombre = 1
      end
      if !validate_number(maestroCA.Telefono)
        errorTelefono = 1
      end
      id_m+=1
      maestroNew.Id_maestro = maestroCA.Id_maestro
      maestroNew.Id_Area_mtro = maestroCA.Id_Area_mtro
      maestroNew.Id_contrato = maestroCA.Id_contrato
      maestroNew.Nombre = maestroCA.Nombre
      maestroNew.CorreoElec = maestroCA.CorreoElec
      maestroNew.Telefono = maestroCA.Telefono
      maestroNew.Titulo = maestroCA.Titulo 
      maestroNew.errorNombre = errorNombre
      maestroNew.errorTelefono = errorTelefono
      maestroNew.save!     
      errorNombre = 0, errorTelefono = 0
    end

    @maestrosE.each do |maestroE|
      if @maestrosCA.exists?(Id_Maestro: maestroE.Id_maestro) == false    
        maestroNew = Maestro.using(:data_warehouse).new
        if validate_name(maestroE.Nombre)
          errorNombre = 1
        end
        if !validate_number(maestroE.Telefono)
          errorTelefono = 1
        end
        id_m += 1
        maestroNew.Id_maestro = id_m
        maestroNew.Clave = maestroE.Id_maestro_extra
        maestroNew.Nombre = maestroE.Nombre
        maestroNew.CorreoElec = maestroE.Correo
        maestroNew.Telefono = maestroE.Telefono
        maestroNew.errorNombre = errorNombre
        maestroNew.errorTelefono = errorTelefono
        maestroNew.save!     
        errorNombre = 0, errorTelefono = 0
      end
    end
  end

end
