class ActividadesPorAlumnoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Actividades_por_alumno.using(:data_warehouse).all.empty?
  end

  def index
    @actividades_data = Actividades_por_alumno.using(:data_warehouse).all
  end
  
  def export_to_sql
    Actividades_por_alumno.using(:data_warehouse_final).delete_all if !Actividades_por_alumno.using(:data_warehouse_final).all.empty?

    actividades = Actividades_por_alumno.using(:data_warehouse).all
    actividades.each do |data|
      Actividades_por_alumno.using(:data_warehouse_final).create(Id_Alumno: data.Id_Alumno,
        Id_actividad: data.Id_actividad, Id_Periodo: data.Id_Periodo, 
        Num_Credito_obtenido: data.Num_Credito_obtenido)
    end
  end
  
  def data 
    actividades = Actividades_por_alumno.using(:data_warehouse).all
  end

  private

    def export
      Actividades_por_alumno.using(:data_warehouse).delete_all if !Actividades_por_alumno.using(:data_warehouse).all.empty?

      @actividades_ex = Actividades_por_alumno.using(:extra).all

      @actividades_ex.each do |actividad|
        actividad_new = Actividades_por_alumno.using(:data_warehouse).new
        actividad_new.Id_Alumno = find_id_alumno(actividad.No_control_a)
        actividad_new.Id_actividad = actividad.Id_actividad
        actividad_new.Id_Periodo = actividad.Id_periodo
        actividad_new.Num_Credito_obtenido = actividad.Creditos
        actividad_new.save!
      end
    end
end
