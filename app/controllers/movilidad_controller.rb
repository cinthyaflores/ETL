class MovilidadController < ApplicationController
  def index  
    @movilidad_data = Movilidad.using(:data_warehouse).all
    export
  end
  
  def edit
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @errores = [@movilidad.errorPais, @movilidad.errorEstado]
  end

  def update
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @errores = [@movilidad.errorPais, @movilidad.errorEstado]

    if @movilidad.update_attributes({País: params[:movilidad][:País], Estado: params[:movilidad][:Estado], errorPais: nil, errorEstado: nil})
      redirect_to "/"
    else
      render :edit
    end
  end
  
  def destroy
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @movilidad.destroy
    redirect_to "/"
  end
  private

  def export
    Movilidad.using(:data_warehouse).delete_all if !Movilidad.using(:data_warehouse).all.empty?

    @movilidad_ca = Movilidad.using(:controlA).all 

    @movilidad_ca.each do |movi|
      movi_new = Movilidad.using(:data_warehouse).new
      if validate_name(movi.País)
        movi_new.errorPais = 1
      end
      if validate_name(movi.Estado)
        movi_new.errorEstado = 1
      end
      movi_new.Id_Movilidad = movi.Id_Movilidad
      movi_new.Id_Carrera = movi.Id_Carrera
      movi_new.País = movi.País
      movi_new.Estado = movi.Estado
      movi_new.Universidad = movi.Universidad
      movi_new.save!   
    end
  end
end

