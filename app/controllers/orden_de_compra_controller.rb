class OrdenDeCompraController < ApplicationController
  def init
    export
  end

  def empty
    return Orden_de_compra.using(:data_warehouse).all.empty?
  end

  def index
    @ordenes_data = Orden_de_compra.using(:data_warehouse).all
  end

  def edit
    @orden = Orden_de_compra.using(:data_warehouse).find_by(Id_orden_compra: params[:id])
    @errores = [@orden.errorCosto, @orden.errorEstado]
  end

  def update
    @orden = Orden_de_compra.using(:data_warehouse).find_by(Id_orden_compra: params[:id])
    @errores = [@orden.errorCosto, @orden.errorEstado]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Orden de compra ID #{params[:id]}: #{@orden.Costo} --> #{params[:orden_de_compra][:Estado]}" if @error != nil

    if @orden.update_attributes(Costo: params[:orden_de_compra][:Costo], errorCosto: nil, Estado: params[:orden_de_compra][:Estado], errorEstado: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/orden_de_compra"
    else
      render :edit
    end
  end

  def destroy
    @orden = Orden_de_compra.using(:data_warehouse).find_by(Id_orden_compra: params[:id])
    @orden.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Orden de compra ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/orden_de_compra"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Orden de compra"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Orden_de_compra.using(:data_warehouse).where(errorCosto: 1).destroy_all
    Orden_de_compra.using(:data_warehouse).where(errorEstado: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @ordenes_data = Orden_de_compra.using(:data_warehouse).all
    case c_user
    when 1
      @ordenes_data.each do |ordenes|
        if ordenes.errorCosto || ordenes.errorEstado
          return true
        end
      end
    when 3
      @ordenes_data.each do |ordenes|
        if ordenes.errorCosto || ordenes.errorEstado
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Orden_de_compra.using(:data_warehouse_final).delete_all if !Orden_de_compra.using(:data_warehouse_final).all.empty?

    recurso = Orden_de_compra.using(:data_warehouse).all
    Orden_de_compra.using(:data_warehouse_final).new
    recurso.each do |data|
      Orden_de_compra.using(:data_warehouse_final).create(Id_orden_compra: data.Id_orden_compra,
                                                          Fecha: data.Fecha, Costo: data.Costo,
                                                          Estado: data.Estado)
    end
  end

  def data
    ordenes = Orden_de_compra.using(:data_warehouse).all
  end

  private

    def export
      Orden_de_compra.using(:data_warehouse).delete_all if !Orden_de_compra.using(:data_warehouse).all.empty?

      @ordenes_extra = Orden_de_compra.using(:extra).all

      Orden_de_compra.using(:data_warehouse).new
      @ordenes_extra.each do |orden|
        orden_new = Orden_de_compra.using(:data_warehouse).new
        orden_new.Id_orden_compra = orden.Id_orden_compra
        orden_new.Fecha = orden.Fecha
        orden_new.Costo = orden.Costo
        orden_new.Estado = orden.Estado
        if !validate_estado(orden_new.Estado)
          orden_new.errorEstado = 1
        end
        if !validate_weight(orden_new.Costo)
          orden_new.errorCosto = 1
        end
        orden_new.save!
      end
    end
end
