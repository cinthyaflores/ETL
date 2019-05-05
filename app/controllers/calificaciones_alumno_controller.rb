class CalificacionesAlumnoController < ApplicationController
  
  def init
    export 
  end

  def empty
    return Calificaciones_alumno.using(:data_warehouse).all.empty?
  end

  def index
    @calificaciones_data = Calificaciones_alumno.using(:data_warehouse).all
  end

  def edit 
    @calificaciones = Calificaciones_alumno.using(:data_warehouse).find_by(id_calif_alu: params[:id])
  end

  def update 
    @calificaciones = Calificaciones_alumno.using(:data_warehouse).find_by(id_calif_alu: params[:id])
    @error = @calificaciones.errorCalif
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Calificaciones/Alumno ID #{params[:id]}: Calificación"

    if @calificaciones.update_attributes(Calificacion: params[:calificaciones_alumno][:Calificacion], errorCalif: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/calificaciones_alumno"
    else
      render :edit
    end
  end

  def destroy 
    @calificaciones = Calificaciones_alumno.using(:data_warehouse).find_by(id_calif_alu: params[:id])
    @calificaciones.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Calificaciones/Alumno ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/calificaciones_alumno"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Calificaciones/Alumno"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Calificaciones_alumno.using(:data_warehouse).where(errorCalif: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @calificaciones = Calificaciones_alumno.using(:data_warehouse).all
    case c_user
    when 1
      @calificaciones.each do |calif|
        if calif.errorCalif
          return true
        end
      end
    when 3
      @calificaciones.each do |calif|
        if calif.errorCalif
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Calificaciones_alumno.using(:data_warehouse_final).delete_all if !Calificaciones_alumno.using(:data_warehouse_final).all.empty?

    calificaciones = Calificaciones_alumno.using(:data_warehouse).all
    Calificaciones_alumno.using(:data_warehouse_final).new
    calificaciones.each do |data|
      Calificaciones_alumno.using(:data_warehouse_final).create(id_calif_alu: data.id_calif_alu,
      Id_Alumno: data.Id_Alumno, Id_nivel: data.Id_nivel, Calificacion: data.Calificacion, Unidad: data.Unidad, Id_Periodo: data.Id_Periodo)
    end

  end
  
  def data 
    calificaciones = Calificaciones_alumno.using(:data_warehouse).all
  end

  private

    def export
      Calificaciones_alumno.using(:data_warehouse).delete_all if !Calificaciones_alumno.using(:data_warehouse).all.empty?

      @calificaciones_extra = Calificaciones_alumno.using(:extra).all

      @calificaciones_extra.each do |calif|
        calif_new = Calificaciones_alumno.using(:data_warehouse).new
        calif_new.id_calif_alu = calif.id_calif_alu
        calif_new.Id_Alumno = find_id_alumno(calif.No_control_a)
        calif_new.Id_nivel = calif.Id_nivel
        calif_new.Calificacion = calif.Calificacion
        calif_new.Unidad = calif.Unidad
        calif_new.Id_Periodo = calif.Id_periodo
        if !validate_calif(calif_new.Calificacion)
          calif_new.errorCalif = 1
        end
        calif_new.save!
      end
    end

end
