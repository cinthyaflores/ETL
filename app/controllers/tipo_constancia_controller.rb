class TipoConstanciaController < ApplicationController

  def init
    export
  end

  def empty
    return Tipo_constancia.using(:data_warehouse).all.empty?
  end

  def index
    @constancia_data = Tipo_constancia.using(:data_warehouse).all
  end

  def edit
    @constancia = Tipo_constancia.using(:data_warehouse).find_by(Id_Tipo_con: params[:id])
    @errores = [@constancia.errorNombre, @constancia.errorCosto]
  end

  def update
    @constancia = Tipo_constancia.using(:data_warehouse).find_by(Id_Tipo_con: params[:id])
    @errores = [@constancia.errorNombre, @constancia.errorCosto]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Tipo Constancia ID #{params[:id]}"

    if @constancia.update_attributes(Nombre: params[:tipo_constancia][:Nombre], errorNombre: nil, Costo: params[:tipo_constancia][:Costo], errorCosto: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/tipo_constancia"
    else
      render :edit
    end
  end

  def destroy
    @constancia = Tipo_constancia.using(:data_warehouse).find_by(Id_Tipo_con: params[:id])
    @constancia.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Tipo constancia ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/tipo_constancia"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Tipo constancia"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Tipo_constancia.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Tipo_constancia.using(:data_warehouse).where(errorCosto: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @constancia_data = Tipo_constancia.using(:data_warehouse).all
    case c_user
    when 1
      @constancia_data.each do |const|
        if const.errorNombre || const.errorCosto
          return true
        end
      end
    when 2
      @constancia_data.each do |const|
        if const.errorCargo || const.errorCosto
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Tipo_constancia.using(:data_warehouse_final).delete_all if !Tipo_constancia.using(:data_warehouse_final).all.empty?

    const = Tipo_constancia.using(:data_warehouse).all
    Tipo_constancia.using(:data_warehouse_final).new
    const.each do |data|
      Tipo_constancia.using(:data_warehouse_final).create(Id_Tipo_con: data.Id_Tipo_con,
                                                          Nombre: data.Nombre, Costo: data.Costo)
    end
  end

  def data
    actividades = Tipo_constancia.using(:data_warehouse).all
  end

  private

    def export
      Tipo_constancia.using(:data_warehouse).delete_all if !Tipo_constancia.using(:data_warehouse).all.empty?

      @constancia_ca = Tipo_constancia.using(:controlA).all

      @constancia_ca.each do |const|
        const_new = Tipo_constancia.using(:data_warehouse).new
        const_new.Id_Tipo_con = const.Id_Tipo_con
        const_new.Nombre = const.Nombre
        const_new.Costo = const.Costo
        if validate_name(const_new.Nombre)
          const_new.errorNombre = 1
        end
        if !validate_weight(const_new.Costo)
          const_new.errorCosto = 1
        end
          const_new.save!
      end
    end
end
