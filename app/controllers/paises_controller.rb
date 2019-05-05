class PaisesController < ApplicationController
  def init
    export
  end

  def empty
    return Paises.using(:data_warehouse).all.empty?
  end

  def index
    @paises_data = Paises.using(:data_warehouse).all
  end

  def edit
    @pais = Paises.using(:data_warehouse).find_by(id_Pais: params[:id])
    @errores = [@pais.errorNombre, @pais.errorClave]
  end

  def update
    @pais = Paises.using(:data_warehouse).find_by(id_Pais: params[:id])
    @errores = [@pais.errorNombre, @pais.errorClave]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Pais ID #{params[:id]}: #{@pais.Nombre} --> #{params[:paises][:Nombre]}" if @error != nil

    if @pais.update_attributes(nombre_pais: params[:paises][:nombre_pais], errorNombre: nil, clave: params[:paises][:clave], errorClave: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/paises"
    else
      render :edit
    end
  end

  def destroy
    @pais = Paises.using(:data_warehouse).find_by(id_Pais: params[:id])
    @pais.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registro - País ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/paises"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Paises"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Paises.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Paises.using(:data_warehouse).where(errorClave: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @paises_data = Paises.using(:data_warehouse).all
    case c_user
    when 1
      @paises_data.each do |pais|
        if pais.errorNombre || pais.errorClave
          return true
        end
      end
    when 4
      @paises_data.each do |pais|
        if pais.errorNombre || pais.errorClave
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Paises.using(:data_warehouse_final).delete_all if !Paises.using(:data_warehouse_final).all.empty?

    pais = Paises.using(:data_warehouse).all
    Paises.using(:data_warehouse_final).new
    pais.each do |data|
      Paises.using(:data_warehouse_final).create(id_Pais: data.id_Pais,
                                                 nombre_pais: data.nombre_pais, clave: data.clave)
    end
  end

  def data
    actividades = Paises.using(:data_warehouse).all
  end

  private

  def export
    Paises.using(:data_warehouse).delete_all if !Paises.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @paises = @biblio.sheet("Paises")

    Paises.using(:data_warehouse).new
    @paises.each_row_streaming(offset: 1) do |pais|
      paises_new = Paises.using(:data_warehouse).new
      paises_new.id_Pais = pais[0].to_s.to_i
      paises_new.nombre_pais = pais[1]
      paises_new.clave = pais[2]
      if validate_name(paises_new.nombre_pais)
        paises_new.errorNombre = 1
      end
      if !validate_clave_pais(paises_new.clave)
        paises_new.errorClave = 1
      end
      paises_new.save!
    end
  end
end
