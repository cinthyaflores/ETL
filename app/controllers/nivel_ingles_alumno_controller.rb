class NivelInglesAlumnoController < ApplicationController
  def init
    export
  end

  def index
    @niveles_alu_data = Nivel_ingles_alumno.using(:data_warehouse).all
    export
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
