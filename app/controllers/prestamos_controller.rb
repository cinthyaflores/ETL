class PrestamosController < ApplicationController
  def init
    export
  end

  def empty
    return Prestamos.using(:data_warehouse).all.empty?
  end

  def edit
    @prestamo = Prestamos.using(:data_warehouse).find_by(Id_prestamo: params[:id])
    @error = @prestamo.errorEstado
  end

  def index
    @prestamos_data = Prestamos.using(:data_warehouse).all
    export
  end

  def update
    @prestamo = Prestamos.using(:data_warehouse).find_by(Id_prestamo: params[:id])
    @error = @prestamo.errorEstado
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Prestamo ID #{params[:id]}: #{@prestamo.Estado} --> #{params[:prestamos][:Estado]}" if @error != nil

    if @prestamo.update_attributes(Estado: params[:prestamos][:Estado], errorEstado: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/prestamos"
    else
      render :edit
    end
  end

  def destroy
    @prestamo = Prestamos.using(:data_warehouse).find_by(Id_prestamo: params[:id])
    @prestamo.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - prestamos ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/prestamos"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Prestamos"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Prestamos.using(:data_warehouse).where(errorEstado: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @prestamos_data = Prestamos.using(:data_warehouse).all
    case c_user
    when 1
      @prestamos_data.each do |prestamo|
        if prestamo.errorEstado
          return true
        end
      end
    when 3
      @prestamos_data.each do |prestamo|
        if prestamo.errorEstado
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Prestamos.using(:data_warehouse_final).delete_all if !Prestamos.using(:data_warehouse_final).all.empty?

    prestamos = Prestamos.using(:data_warehouse).all
    Prestamos.using(:data_warehouse_final).new
    prestamos.each do |data|
      Prestamos.using(:data_warehouse_final).create(Id_prestamo: data.Id_prestamo,
                                                    Id_maestro_ex: data.Id_maestro_ex, Id_periodo: data.Id_periodo,
                                                    Fechaprestamo: data.Fechaprestamo, Fechaentrega: data.Fechaentrega,
                                                    Estado: data.Estado)
    end
  end

  def data
    actividades = Prestamos.using(:data_warehouse).all
  end

  private

    def export
      Prestamos.using(:data_warehouse).delete_all if !Prestamos.using(:data_warehouse).all.empty?

      @prestamos_extra = Prestamos.using(:extra).all 

      @prestamos_extra.each do |prestamo|
        prestamo_new = Prestamos.using(:data_warehouse).new
        prestamo_new.Id_maestro_ex = find_id_maestro(prestamo.Id_maestro)
        prestamo_new.Id_prestamo = prestamo.Id_prestamo
        prestamo_new.Id_periodo = prestamo.Id_periodo
        prestamo_new.Fechaprestamo = prestamo.Fechaprestamo
        prestamo_new.Fechaentrega = prestamo.Fechaentrega
        prestamo_new.Estado = prestamo.Estado
        if !validate_estado_tres(prestamo.Estado)
          prestamo_new.errorEstado = 1
        end
        prestamo_new.save!
      end
    end
end
