# frozen_string_literal: true

class MovilidadController < ApplicationController
  def init
    export
  end

  def empty
    return Movilidad.using(:data_warehouse).all.empty?
  end

  def index
    @movilidad_data = Movilidad.using(:data_warehouse).all
  end

  def edit
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @errores = [@movilidad.errorPais, @movilidad.errorEstado]
  end

  def update
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @errores = [@movilidad.errorPais, @movilidad.errorEstado]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - movilidad ID #{params[:id]}: #{@movilidad.País} --> #{params[:movilidad][:País]}" if @error != nil

    if @movilidad.update_attributes(País: params[:movilidad][:País], Estado: params[:movilidad][:Estado], errorPais: nil, errorEstado: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/movilidad"
    else
      render :edit
    end
  end

  def destroy
    @movilidad = Movilidad.using(:data_warehouse).find_by(Id_Movilidad: params[:id])
    @movilidad.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Movilidad ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/movilidad"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Movilidad"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Movilidad.using(:data_warehouse).where(errorPais: 1).destroy_all
    Movilidad.using(:data_warehouse).where(errorEstado: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @movilidad_data = Movilidad.using(:data_warehouse).all
    case c_user
    when 1
      @movilidad_data.each do |mov|
        if mov.errorPais || mov.errorEstado
          return true
        end
      end
    when 2
      @movilidad_data.each do |mov|
        if mov.errorPais || mov.errorEstado
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Movilidad.using(:data_warehouse_final).delete_all if !Movilidad.using(:data_warehouse_final).all.empty?

    movilidad = Movilidad.using(:data_warehouse).all
    Movilidad.using(:data_warehouse_final).new
    movilidad.each do |data|
      Movilidad.using(:data_warehouse_final).create(Id_Movilidad: data.Id_Movilidad,
                                                    Id_Carrera: data.Id_Carrera, País: data.País,
                                                    Estado: data.Estado, Universidad: data.Universidad)
    end
  end

  def data
    actividades = Movilidad.using(:data_warehouse).all
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
