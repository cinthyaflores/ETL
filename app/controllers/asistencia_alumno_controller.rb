class AsistenciaAlumnoController < ApplicationController

  def init
    export 
  end

  def empty
    return Asistencia_alumno.using(:data_warehouse).all.empty?
  end

  def index
    @asistencia_alumno_data = Asistencia_alumno.using(:data_warehouse).all

  end

  def edit 
    @asistencia_alumno = Asistencia_alumno.using(:data_warehouse).find_by(id_asistencia_alumno: params[:id])
    @errores = [@asistencia_alumno.errorAsistencias,@asistencia_alumno.errorFaltas, @asistencia_alumno.errorRetardos]
    puts @errores
  end

  def update 
    @asistencia_alumno = Asistencia_alumno.using(:data_warehouse).find_by(id_asistencia_alumno: params[:id])
    @errores = [@asistencia_alumno.errorAsistencias,@asistencia_alumno.errorFaltas, @asistencia_alumno.errorRetardos]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campos = Array.new
    campos.push("Actualizó - Asistencia Alumno Act. ID #{params[:id]}: Asistencias") if @asistencia_alumno.errorAsistencias
    campos.push("Actualizó - Asistencia Alumno Act. ID #{params[:id]}: Faltas") if @asistencia_alumno.errorFaltas
    campos.push("Actualizó - Asistencia Alumno Act. ID #{params[:id]}: Retardos") if @asistencia_alumno.errorRetardos

    if @asistencia_alumno.update_attributes(Asistencias: params[:asistencia_alumno][:Asistencias], Retardos: params[:asistencia_alumno][:Retardos], Faltas: params[:asistencia_alumno][:Faltas],errorAsistencias: nil, errorFaltas: nil, errorRetardos:nil)
      User_logins.using(:data_warehouse).all
      campos.each do |campo|
        User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)
      end
      redirect_to "/asistencia_alumno"
    else
      render :edit
    end
  end

  def destroy 
    @asistencia_alumno = Asistencia_alumno.using(:data_warehouse).find_by(id_asistencia_alumno: params[:id])
    @asistencia_alumno.destroy

    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Asistencia Alumno ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)

    redirect_to "/asistencia_alumno"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Asistencia Alumno Act."
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)

    Asistencia_alumno.using(:data_warehouse).where(errorAsistencias: 1).destroy_all
    Asistencia_alumno.using(:data_warehouse).where(errorRetardos: 1).destroy_all
    Asistencia_alumno.using(:data_warehouse).where(errorFaltas: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @adeudos_data = Asistencia_alumno.using(:data_warehouse).all
    case c_user
    when 1
      @adeudos_data.each do |adeudo|
        if adeudo.errorAsistencias || adeudo.errorRetardos || adeudo.errorFaltas 
          return true
        end
      end
    when 3
      @adeudos_data.each do |adeudo|
        if adeudo.errorAsistencias || adeudo.errorRetardos || adeudo.errorFaltas 
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
      Asistencia_alumno.using(:data_warehouse_final).create(id_asistencia_alumno: data.id_asistencia_alumno,
        Id_alumno: data.Id_alumno, Id_Periodo: data.Id_Periodo, Asistencias: data.Id_Periodo, Faltas: data.Faltas, Retardos: data.Retardos)
    end
  end
  
  def data 
    asistencias = Asistencia_alumno.using(:data_warehouse).all
  end

  private

    def export
      Asistencia_alumno.using(:data_warehouse).delete_all if !Asistencia_alumno.using(:data_warehouse).all.empty?

      @asistencia_alumno_extra = Asistencia_alumno.using(:extra).all

      Asistencia_alumno.using(:data_warehouse).new
      @asistencia_alumno_extra.each do |asistencia|
        asistencia_new = Asistencia_alumno.using(:data_warehouse).new
        asistencia_new.id_asistencia_alumno = asistencia.id_asistencia_alumno
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
