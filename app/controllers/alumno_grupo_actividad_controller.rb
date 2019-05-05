class AlumnoGrupoActividadController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Alumno_grupo_actividad.using(:data_warehouse).all.empty?
  end
  
  def index
    @alumno_grupo_data = Alumno_grupo_actividad.using(:data_warehouse).all.order(:Id_Alumno)
  end

  def export_to_sql
    Alumno_grupo_actividad.using(:data_warehouse_final).delete_all if !Alumno_grupo_actividad.using(:data_warehouse_final).all.empty?

    alumno = Alumno_grupo_actividad.using(:data_warehouse).all
    alumno.each do |data|
      Alumno_grupo_actividad.using(:data_warehouse_final).create(Id_Alumno: data.Id_Alumno,
      Id_grupo_Ac: data.Id_grupo_Ac, Id_periodo: data.Id_periodo)
    end
  end
  
  def data 
    alumno = Alumno_grupo_actividad.using(:data_warehouse).all
  end

  private

    def export
      Alumno_grupo_actividad.using(:data_warehouse).delete_all if !Alumno_grupo_actividad.using(:data_warehouse).all.empty?

      @alumno_grupo_extra = Alumno_grupo_actividad.using(:extra).all

      @alumno_grupo_extra.each do |alumno|
        actividad_new = Alumno_grupo_actividad.using(:data_warehouse).new
        actividad_new.Id_Alumno = find_id_alumno(alumno.No_control_a)
        actividad_new.Id_grupo_Ac = alumno.Id_grupo_A
        actividad_new.Id_periodo = alumno.Id_periodo
        actividad_new.save!
      end
    end
end
