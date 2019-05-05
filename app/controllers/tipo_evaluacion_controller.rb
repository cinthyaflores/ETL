class TipoEvaluacionController < ApplicationController

  def init
    export
  end

  def empty
    return Tipo_evaluacion.using(:data_warehouse).all.empty?
  end

  def index
    @tipo_eva_data = Tipo_evaluacion.using(:data_warehouse).all
  end

  def edit 
    @tipo_eva = Tipo_evaluacion.using(:data_warehouse).find_by(Id_Tipo_Eva: params[:id])
    @error = @tipo_eva.errorNombre
  end

  def update 
    @tipo_eva = Tipo_evaluacion.using(:data_warehouse).find_by(Id_Tipo_Eva: params[:id])
    @error = @tipo_eva.errorNombre
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó Tipo Evaluación ID #{params[:id]}: Nombre" if @error != nil

    if @tipo_eva.update_attributes(Nombre: params[:tipo_evaluacion][:Nombre], errorNombre: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/tipo_evaluacion"
    else
      render :edit
    end
  
  end

  def destroy 
    @tipo_eva = Tipo_evaluacion.using(:data_warehouse).find_by(Id_Tipo_Eva: params[:id])
    @tipo_eva.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Tipo Evaluación ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/tipo_evaluacion"
  end

  def delete_table 
    Tipo_evaluacion.using(:data_warehouse).where(errorNombre: 1).destroy_all
    
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Tipo Evaluación"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @evaluacion = Tipo_evaluacion.using(:data_warehouse).all
    case c_user
    when 1
      @evaluacion.each do |eva|
        if eva.errorNombre
          return true
        end
      end
    when 2
      @evaluacion.each do |eva|
        if eva.errorNombre 
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Tipo_evaluacion.using(:data_warehouse_final).delete_all if !Tipo_evaluacion.using(:data_warehouse_final).all.empty?

    const = Tipo_evaluacion.using(:data_warehouse).all
    Tipo_evaluacion.using(:data_warehouse_final).new
    const.each do |data|
      Tipo_evaluacion.using(:data_warehouse_final).create(Id_Tipo_Eva: data.Id_Tipo_Eva,
        Nombre: data.Nombre, Descripción: data.Descripción)
    end
  end

  def data
    actividades = Tipo_evaluacion.using(:data_warehouse).all
  end

  private

    def export
      Tipo_evaluacion.using(:data_warehouse).delete_all if !Tipo_evaluacion.using(:data_warehouse).all.empty?

      tipo_eva = Tipo_evaluacion.using(:controlA).all

      tipo_eva.each do |tipo|
        tipo_new = Tipo_evaluacion.using(:data_warehouse).new
        tipo_new.Id_Tipo_Eva = tipo.Id_Tipo_Eva
        tipo_new.Nombre = tipo.Nombre
        if validate_name(tipo.Nombre)
          tipo_new.errorNombre = 1 
        end
        tipo_new.Descripción = tipo.Descripción
        tipo_new.save!
      end

    end
end
