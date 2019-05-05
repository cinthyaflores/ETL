# frozen_string_literal: true

class MateriaController < ApplicationController

  def init
    export
  end

  def empty
    return Materia.using(:data_warehouse).all.empty?
  end

  def index
    @materias_data = Materia.using(:data_warehouse).all
  end

  def edit
    @materia = Materia.using(:data_warehouse).find_by(Id_Materia: params[:id])
    @errores = [@materia.errorNombre, @materia.errorCreditos]
  end

  def update
    @materia = Materia.using(:data_warehouse).find_by(Id_Materia: params[:id])
    @errores = [@materia.errorNombre, @materia.errorCreditos]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Materia ID #{params[:id]}: #{@materia.Nombre} --> #{params[:materia][:Nombre]}" if @error != nil

    if @materia.update_attributes(Nombre: params[:materia][:Nombre], errorNombre: nil, Créditos: params[:materia][:Créditos], errorCreditos: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/materia"
    else
      render :edit
    end
  end

  def destroy
    @materia = Materia.using(:data_warehouse).find_by(Id_Materia: params[:id])
    @materia.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Materia ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/materia"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Materia"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Materia.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Materia.using(:data_warehouse).where(errorCreditos: 1).destroy_all
    redirect_to "/show_tables"
  end


  def verify(c_user)
    @materias_data = Materia.using(:data_warehouse).all
    case c_user
    when 1
      @materias_data.each do |mater|
        if mater.errorNombre || mater.errorCreditos
          return true
        end
      end
    when 2
      @materias_data.each do |mater|
        if mater.errorNombre || mater.errorCreditos
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Materia.using(:data_warehouse_final).delete_all if !Materia.using(:data_warehouse_final).all.empty?

    materia = Materia.using(:data_warehouse).all
    Materia.using(:data_warehouse_final).new
    materia.each do |data|
      Materia.using(:data_warehouse_final).create(Id_Materia: data.Id_Materia,
                                                  Nombre: data.Nombre, Clave: data.Clave,
                                                  Créditos: data.Créditos)
    end
  end

  def data
    materia = Materia.using(:data_warehouse).all
  end

  private

    def export
      Materia.using(:data_warehouse).delete_all if !Materia.using(:data_warehouse).all.empty?

      @materias_ca = Materia.using(:controlA).all

      @materias_ca.each do |materia|
        materia_new = Materia.using(:data_warehouse).new
        materia_new.Id_Materia = materia.Id_Materia
        materia_new.Nombre = materia.Nombre
        materia_new.Clave = materia.Clave
        materia_new.Créditos = materia.Créditos
        if validate_name(materia_new.Nombre)
          materia_new.errorNombre = 1
        end
        if !validate_creditos(materia_new.Créditos)
          materia_new.errorCreditos = 1
        end

        materia_new.save!
      end
    end
end
