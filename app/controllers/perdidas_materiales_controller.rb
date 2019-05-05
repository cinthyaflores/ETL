class PerdidasMaterialesController < ApplicationController

  def init
    export
  end

  def empty
    return Perdidas_materiales.using(:data_warehouse).all.empty?
  end

  def index
    @perdidas_data = Perdidas_materiales.using(:data_warehouse).all
  end

  def edit
    @perdida = Perdidas_materiales.using(:data_warehouse).find_by(Id_perdida: params[:id])
    @errores = [@perdida.errorCosto, @perdida.errorCantidad]
  end

  def update
    @perdida = Perdidas_materiales.using(:data_warehouse).find_by(Id_perdida: params[:id])
    @errores = [@perdida.errorCosto, @perdida.errorCantidad]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Perdida Material ID #{params[:id]}: #{@perdida.Costo_total} --> #{params[:perdidas_materiales][:Costo_total]}" if @error != nil

    if @perdida.update_attributes(Costo_total: params[:perdidas_materiales][:Costo_total], errorCosto: nil, Cantidad: params[:perdidas_materiales][:Cantidad], errorCantidad: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/perdidas_materiales"
    else
      render :edit
    end
  end

  def destroy
    @perdida = Perdidas_materiales.using(:data_warehouse).find_by(Id_perdida: params[:id])
    @perdida.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Perdidas materiales ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/perdidas_materiales"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Perdidas Materiales"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Perdidas_materiales.using(:data_warehouse).where(errorCantidad: 1).destroy_all
    Perdidas_materiales.using(:data_warehouse).where(errorCosto: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @perdidas_data = Perdidas_materiales.using(:data_warehouse).all
    case c_user
    when 1
      @perdidas_data.each do |perdida|
        if perdida.errorCosto || perdida.errorCantidad
          return true
        end
      end
    when 3
      @perdidas_data.each do |perdida|
        if perdida.errorCosto || perdida.errorCantidad
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Perdidas_materiales.using(:data_warehouse_final).delete_all if !Perdidas_materiales.using(:data_warehouse_final).all.empty?

    perdida = Perdidas_materiales.using(:data_warehouse).all
    Perdidas_materiales.using(:data_warehouse_final).new
    perdida.each do |data|
      Perdidas_materiales.using(:data_warehouse_final).create(Id_perdida: data.Id_perdida,
                                                              Id_recurso: data.Id_recurso, Id_prestamo: data.Id_prestamo,
                                                              Cantidad: data.Cantidad, Costo_total: data.Costo_total)
    end
  end

  def data
    actividades = Perdidas_materiales.using(:data_warehouse).all
  end

  private

    def export
      Perdidas_materiales.using(:data_warehouse).delete_all if !Perdidas_materiales.using(:data_warehouse).all.empty?

      @perdidas_extra = Perdidas_materiales.using(:extra).all 

      @perdidas_extra.each do |perdida|
        perdida_new = Perdidas_materiales.using(:data_warehouse).new
        perdida_new.Id_perdida = perdida.Id_perdida
        perdida_new.Id_recurso = perdida.IdRM
        perdida_new.Id_prestamo = perdida.Id_prestamo
        perdida_new.Cantidad = perdida.Cantidad
        perdida_new.Costo_total = perdida.Costo_total
        if !validate_weight(perdida_new.Costo_total)
          perdida_new.errorCosto = 1
        end
        if !validate_weight(perdida_new.Cantidad)
          perdida_new.errorCantidad = 1
        end
        perdida_new.save!
      end
    end
end
