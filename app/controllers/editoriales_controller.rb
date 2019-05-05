class EditorialesController < ApplicationController

  def init
    export
  end

  def empty
    return Editorial.using(:data_warehouse).all.empty?
  end

  def index
    @editoriales_data = Editorial.using(:data_warehouse).all
  end

  def edit
    @editorial = Editorial.using(:data_warehouse).find_by(Id_Editorial: params[:id])
    @errores = [@editorial.errorNombre, @editorial.errorTelefono]
  end

  def update
    @editorial = Editorial.using(:data_warehouse).find_by(Id_Editorial: params[:id])
    @errores = [@editorial.errorNombre, @editorial.errorTelefono]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Editoriales ID #{params[:id]}: #{@editorial.Nombre} --> #{params[:editorial][:Nombre]}" if @error != nil

    if @editorial.update_attributes(Nombre: params[:editorial][:Nombre], errorNombre: nil, Telefono: params[:editorial][:Telefono], errorTelefono: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/editoriales"
    else
      render :edit
    end
  end

  def destroy
    @editorial = Editorial.using(:data_warehouse).find_by(Id_Editorial: params[:id])
    @editorial.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Editorial ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/editoriales"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Editorial"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Editorial.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Editorial.using(:data_warehouse).where(errorTelefono: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @editoriales_data = Editorial.using(:data_warehouse).all
    case c_user
    when 1
      @editoriales_data.each do |editorial|
        if editorial.errorNombre || editorial.errorTelefono
          return true
        end
      end
    when 4
      @editoriales_data.each do |editorial|
        if editorial.errorNombre || editorial.errorTelefono
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Editorial.using(:data_warehouse_final).delete_all if !Editorial.using(:data_warehouse_final).all.empty?

    editorial = Editorial.using(:data_warehouse).all
    Editorial.using(:data_warehouse_final).new
    editorial.each do |data|
      Editorial.using(:data_warehouse_final).create(Id_Editorial: data.Id_Editorial,
                                                    Nombre: data.Nombre, CP: data.CP,
                                                    Direccion: data.Direccion, Telefono: data.Telefono,
                                                    Id_Pais: data.Id_Pais)
    end
  end

  def data
    actividades = Editorial.using(:data_warehouse).all
  end

  private

  def export
    Editorial.using(:data_warehouse).delete_all if !Editorial.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @editoriales_b = @biblio.sheet("Editoriales")

    @editoriales_b.each_row_streaming(offset: 1) do |editorial|
      editorial_new = Editorial.using(:data_warehouse).new
      editorial_new.Id_Editorial = editorial[0].value
      editorial_new.Nombre = editorial[1].value
      editorial_new.CP = editorial[2].value
      editorial_new.Direccion = editorial[3]
      editorial_new.Telefono = editorial[4]
      editorial_new.Id_Pais = editorial[5].value
      if validate_name(editorial_new.Nombre)
        editorial_new.errorNombre = 1
      end
      if !validate_number(editorial_new.Telefono)
        editorial_new.errorTelefono = 1
      end
      editorial_new.save!
    end
  end
end
