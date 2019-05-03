class AsistenciaAlumnoController < ApplicationController

  def init
    export 
  end

  def empty
    return Asistencia_alumno.using(:data_warehouse).all.empty?
  end

  def index
    @asistencia_alumno_data = Asistencia_alumno.using(:data_warehouse).all
    export
  end

  def edit 
    @asistencias = Asistencia_alumno.using(:data_warehouse).find_by(Id_asistencia_alumno: params[:id])
  end

  def update 
    @asistencias = Asistencia_alumno.using(:data_warehouse).find_by(Id_asistencia_alumno: params[:id])
    @errores = [@asistencias.errorAsistencia,@asistencias.errorFaltas,@asistencias.errorRetardo]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Asistencia Alumno ID #{params[:id]}"

    if @asistencias.update_attributes(Cargo_Dia: params[:adeudos][:Cargo_Dia], errorCargo: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/asistencia_alumno"
    else
      render :edit
    end
  end

  def destroy 
    @asistencias = Asistencia_alumno.using(:data_warehouse).find_by(Id_alumno: params[:id])
    @asistencias.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Asistencia Alumno ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/asistencia_alumno"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Asistencia Alumno Act."
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Asistencia_alumno.using(:data_warehouse).where(errorCargo: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @adeudos_data = Asistencia_alumno.using(:data_warehouse).all
    case c_user
    when 1
      @adeudos_data.each do |adeudo|
        if adeudo.errorCargo
          return true
        end
      end
    when 3
      @adeudos_data.each do |adeudo|
        if adeudo.errorCargo
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Asistencia_alumno.using(:data_warehouse_final).delete_all if !Asistencia_alumno.using(:data_warehouse_final).all.empty?

    asistencias = Asistencia_alumno.using(:data_warehouse).all
    Asistencia_alumno.using(:data_warehouse_final).new
    asistencias.each do |data|
      Asistencia_alumno.using(:data_warehouse_final).create(id_Adeudos: data.id_Adeudos,
      id_Prestamo: data.id_Prestamo, Cargo_Dia: data.Cargo_Dia)
    end
  end
  
  def data 
    asistencias = Asistencia_alumno.using(:data_warehouse).all
  end

  private

    def export
      Asistencia_alumno.using(:data_warehouse).delete_all if !Asistencia_alumno.using(:data_warehouse).all.empty?

      @asistencia_alumno_extra = Asistencia_alumno.using(:extra).all

      @asistencia_alumno_extra.each do |asistencia|
        asistencia_new = Asistencia_alumno.using(:data_warehouse).new
        asistencia_new.Id_alumno = find_id_alumno(asistencia.No_control_a)
        asistencia_new.Id_Periodo = asistencia.Id_periodo
        asistencia_new.Asistencias = asistencia.Asistencias
        asistencia_new.Faltas = asistencia.Faltas
        asistencia_new.Retardos = asistencia.Retardos
        if !validate_weight(asistencia.Asistencias)
          asistencia_new.errorAsistencias = 1
        end
        if !validate_weight(asistencia.Faltas)
          asistencia_new.errorFaltas = 1
        end
        if !validate_weight(asistencia.Retardos)
          asistencia_new.errorRetardos = 1
        end
        asistencia_new.save!
      end
    end
end
