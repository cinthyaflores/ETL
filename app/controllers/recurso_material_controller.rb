class RecursoMaterialController < ApplicationController

  def init
    export
  end

  def empty
    return Recurso_material.using(:data_warehouse).all.empty?
  end

  def index
    @recursos_data = Recurso_material.using(:data_warehouse).all
  end

  def edit
    @recurso = Recurso_material.using(:data_warehouse).find_by(Id_recurso: params[:id])
    @errores = [@recurso.errorNombre, @recurso.errorCosto, @recurso.errorCantidad]
  end

  def update
    @recurso = Recurso_material.using(:data_warehouse).find_by(Id_recurso: params[:id])
    @errores = [@recurso.errorNombre, @recurso.errorCosto, @recurso.errorCantidad]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Recurso material ID #{params[:id]}: #{@recurso.Nombre} --> #{params[:recurso_material][:Nombre]}" if @error != nil

    if @recurso.update_attributes(Nombre: params[:recurso_material][:Nombre], errorNombre: nil, Costo: params[:recurso_material][:Costo], errorCosto: nil, Cantidad: params[:recurso_material][:Cantidad], errorCantidad: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/recurso_material"
    else
      render :edit
    end

  end

  def destroy
    @recurso = Recurso_material.using(:data_warehouse).find_by(Id_recurso: params[:id])
    @recurso.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Recurso Material ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/recurso_material"
  end

  def delete_table
    Recurso_material.using(:data_warehouse).all
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Recurso Material"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Recurso_material.using(:data_warehouse).all
    Recurso_material.using(:data_warehouse).where(errorNombre: 1).delete_all
    Recurso_material.using(:data_warehouse).where(errorCosto: 1).delete_all
    Recurso_material.using(:data_warehouse).where(errorCantidad: 1).delete_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @recursos_data = Recurso_material.using(:data_warehouse).all
    case c_user
    when 1
      @recursos_data.each do |recurso|
        if recurso.errorNombre || recurso.errorCosto || recurso.errorCantidad
          return true
        end
      end
    when 3
      @recursos_data.each do |recurso|
        if recurso.errorNombre || recurso.errorCosto || recurso.errorCantidad
          return true
        end
      end
    end
    return false

  end

  def export_to_sql
    Recurso_material.using(:data_warehouse_final).delete_all if !Recurso_material.using(:data_warehouse_final).all.empty?

    recurso = Recurso_material.using(:data_warehouse).all
    Recurso_material.using(:data_warehouse_final).new
    recurso.each do |data|
      Recurso_material.using(:data_warehouse_final).create(Id_recurso: data.Id_recurso,
                                                           Area_pertenece: data.Area_pertenece, Nombre: data.Nombre,                                                           Cantidad: data.Cantidad, Costo: data.Costo)
    end

  end

  def data
    actividades = Recurso_material.using(:data_warehouse).all
  end

  private

    def export
      Recurso_material.using(:data_warehouse).delete_all if !Recurso_material.using(:data_warehouse).all.empty?

      @recursos_extra = Recurso_material.using(:extra).all 

      @recursos_extra.each do |recurso|
        recurso_new = Recurso_material.using(:data_warehouse).new
        recurso_new.Id_recurso = recurso.Id_recurso
        recurso_new.Area_pertenece = recurso.Area_pertenece
        recurso_new.Nombre = recurso.Nombre
        recurso_new.Cantidad = recurso.Cantidad
        recurso_new.Costo = recurso.Costo
        if validate_name(recurso_new.Nombre)
          recurso_new.errorNombre = 1
        end
        if !validate_weight(recurso_new.Costo)
          recurso_new.errorCosto = 1
        end
        if !validate_weight(recurso_new.Cantidad)
          recurso_new.errorCantidad = 1
        end
        recurso_new.save!
      end

    end
  end