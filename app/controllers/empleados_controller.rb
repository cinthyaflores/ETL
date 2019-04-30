class EmpleadosController < ApplicationController
  def init
    export
  end

  def index
    @empleados_data = Empleado.using(:data_warehouse).all.order(:idEmpleado)
    export
    verify
  end

  def edit
    @empleado = Empleado.using(:data_warehouse).find_by(idEmpleado: params[:id])
    @errores = [@empleado.errorNombre, @empleado.errorTelefono, @empleado.errorCorreo]
  end

  def update
    @empleado = Empleado.using(:data_warehouse).find_by(idEmpleado: params[:id])
    @errores = [@empleado.errorNombre, @empleado.errorTelefono, @empleado.errorCorreo]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campos_modificados = Array.new
    campos_modificados.push("Actializó Empleado ID #{params[:id]}: Nombre") if @errores[0] != nil
    campos_modificados.push("Actializó Empleado ID #{params[:id]}: Telefono") if @errores[1] != nil
    campos_modificados.push("Actializó Empleado ID #{params[:id]}: Correo") if @errores[2] != nil
   
    if @empleado.update_attributes(nombre_empleado: params[:empleado][:nombre_empleado], telefono: params[:empleado][:telefono], email: params[:empleado][:email], errorNombre: nil, errorTelefono: nil, errorCorreo: nil)
      User_logins.using(:data_warehouse).all
      campos_modificados.each do |campo|
        User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)
      end
      redirect_to "/"
    else
      render :edit
    end
  end

  def destroy
    @empleado = Empleado.using(:data_warehouse).find_by(idEmpleado: params[:id])
    @empleado.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Empleado ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/"
  end

  def delete_table
    Empleado.using(:data_warehouse).where(errorNombre: 1).destroy_all
    Empleado.using(:data_warehouse).where(errorTelefono: 1).destroy_all
    Empleado.using(:data_warehouse).where(errorCorreo: 1).destroy_all
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Empleado"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/empleados"
  end
  

  private

    def verify
      @empleados_data.each do |empleado|
        if empleado.errorNombre || empleado.errorTelefono || empleado.errorCorreo
          @errores = true
        end
      end
    end

    def export
      Empleado.using(:data_warehouse).delete_all if !Empleado.using(:data_warehouse).all.empty?

      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @empleados_bi = @biblio.sheet("Empleados")

      @empleados_bi.each_row_streaming(offset: 1) do |empleado| 
        empleado_new = Empleado.using(:data_warehouse).new
        empleado_new.idEmpleado = empleado[0].value
        empleado_new.nombre_empleado = empleado[1].value
        empleado_new.fec_nac = empleado[2].value
        empleado_new.direccion = empleado[3].value
        empleado_new.telefono = empleado[4].value
        empleado_new.email = empleado[5].value
        empleado_new.id_turno = empleado[6].value
        if validate_name(empleado_new.nombre_empleado)
          empleado_new.errorNombre = 1
        end
        if !validate_number(empleado_new.telefono)
          empleado_new.errorTelefono = 1
        end
        if !validate_email(empleado_new.email)
          empleado_new.errorCorreo = 1
        end
        empleado_new.save!
      end      
    end

end
