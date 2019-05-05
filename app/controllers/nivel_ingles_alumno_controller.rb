class NivelInglesAlumnoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Nivel_ingles_alumno.using(:data_warehouse).all.empty?
  end

  def index
    @niveles_alu_data = Nivel_ingles_alumno.using(:data_warehouse).all
  end

  def export_to_sql
    Nivel_ingles_alumno.using(:data_warehouse_final).delete_all if !Nivel_ingles_alumno.using(:data_warehouse_final).all.empty?

    niveles = Nivel_ingles_alumno.using(:data_warehouse).all
    niveles.each do |data|
      Nivel_ingles_alumno.using(:data_warehouse_final).create(
        Id_Periodo: data.Id_Periodo, Id_Alumno: data.Id_Alumno, 
        Id_nivel: data.Id_nivel, Creditos: data.Creditos, Calificacion: data.Calificacion)
    end
  end
  
  def data 
    niveles = Nivel_ingles_alumno.using(:data_warehouse).all
  end

  private

    def export
      Nivel_ingles_alumno.using(:data_warehouse).delete_all if !Nivel_ingles_alumno.using(:data_warehouse).all.empty?

      @niveles_alu_extra = Nivel_ingles_alumno.using(:extra).all 

      @niveles_alu_extra.each do |nivel|
        nivel_new = Nivel_ingles_alumno.using(:data_warehouse).new
        nivel_new.Id_Alumno = find_id_alumno(nivel.No_control_a)
        nivel_new.Id_Periodo = nivel.Id_periodo
        nivel_new.Id_nivel = nivel.Id_nivel
        nivel_new.Creditos = nivel.Creditos
        nivel_new.Calificacion = nivel.Calificacion
        nivel_new.save!
      end
    end
end
