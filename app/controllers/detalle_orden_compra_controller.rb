class DetalleOrdenCompraController < ApplicationController

  def init
    export 
  end

  def empty
    return Detalle_orden_compra.using(:data_warehouse).all.empty?
  end

  def index
    @orden_data = Detalle_orden_compra.using(:data_warehouse).all
  end

  def edit 
    @detalle_ord = Detalle_orden_compra.using(:data_warehouse).find_by(id_detalle_orden: params[:id])
    @errores = [@detalle_ord.errorCosto,@detalle_ord.errorCantidad]
  end

  def update 
    @detalle_ord = Detalle_orden_compra.using(:data_warehouse).find_by(id_detalle_orden: params[:id])
    @errores = [@detalle_ord.errorCosto,@detalle_ord.errorCantidad]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    if @detalle_ord.errorCosto == 1 && @detalle_ord.errorCantidad == 1
      campo_modificado = "Actualizó - Detalle Orden ID #{params[:id]}: Costo y Cantidad"
    elsif @detalle_ord.errorCosto == 1 
      campo_modificado = "Actualizó - Detalle Orden ID #{params[:id]}"
    else
      campo_modificado = "Actualizó - Detalle Orden ID #{params[:id]}: Cantidad"
    end

    if @detalle_ord.update_attributes(Costo_unitario: params[:detalle_orden_compra][:Costo_unitario], Cantidad: params[:detalle_orden_compra][:Cantidad], errorCosto: nil, errorCantidad: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/detalle_orden_compra"
    else
      render :edit
    end
  end

  def destroy 
    @detalle_ord = Detalle_orden_compra.using(:data_warehouse).find_by(id_detalle_orden: params[:id])
    @detalle_ord.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Detalle Orden ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/detalle_orden_compra"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Detalle Orden"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Detalle_orden_compra.using(:data_warehouse).where(errorCosto: 1).destroy_all
    Detalle_orden_compra.using(:data_warehouse).where(errorCantidad: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @detalle_ord = Detalle_orden_compra.using(:data_warehouse).all
    case c_user
    when 1
      @detalle_ord.each do |detalle|
        if detalle.errorCantidad || detalle.errorCosto 
          return true
        end
      end
    when 3
      @detalle_ord.each do |detalle|
        if detalle.errorCantidad || detalle.errorCosto 
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Detalle_orden_compra.using(:data_warehouse_final).delete_all if !Detalle_orden_compra.using(:data_warehouse_final).all.empty?

    detalle = Detalle_orden_compra.using(:data_warehouse).all
    Detalle_orden_compra.using(:data_warehouse_final).new
    detalle.each do |data|
      Detalle_orden_compra.using(:data_warehouse_final).create(id_detalle_orden: data.id_detalle_orden,
      Id_orden_compra: data.Id_orden_compra, Id_recurso: data.Id_recurso,Cantidad: data.Cantidad,Costo_unitario: data.Costo_unitario)
    end
  end
  
  def data 
    detalle_ord = Detalle_orden_compra.using(:data_warehouse).all
  end

  private

    def export
      Detalle_orden_compra.using(:data_warehouse).delete_all if !Detalle_orden_compra.using(:data_warehouse).all.empty?

      @orden_extra = Detalle_orden_compra.using(:extra).all

      @orden_extra.each do |orden|
        orden_new = Detalle_orden_compra.using(:data_warehouse).new
        orden_new.id_detalle_orden = orden.id_detalle_orden
        orden_new.Id_orden_compra = orden.Id_orden_compra
        orden_new.Id_recurso = orden.IdRM
        orden_new.Cantidad = orden.Cantidad
        orden_new.Costo_unitario = orden.Costo_unitario
        if !validate_weight(orden_new.Cantidad)
          orden_new.errorCantidad = 1
        end
        if !validate_weight(orden_new.Costo_unitario)
          orden_new.errorCosto = 1
        end
        orden_new.save!
      end
    end
end
