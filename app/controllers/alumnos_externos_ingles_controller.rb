class AlumnosExternosInglesController < ApplicationController
  def index
    @alumnos_ext_data = Alumnos_externos_ingles.using(:data_warehouse).all.order(:Id_Alumno)
    export
  end

  private

    def export
      Alumnos_externos_ingles.using(:data_warehouse).delete_all if !Alumnos_externos_ingles.using(:data_warehouse).all.empty?

      @alumnos_ext_extra = Alumnos_externos_ingles.using(:extra).all

      @alumnos_ext_extra.each do |alumno|
        alumno_new = Alumnos_externos_ingles.using(:data_warehouse).new
        alumno_new.Id_Alumno = find_id_alumno(alumno.No_control_a)
        alumno_new.Id_escuela = alumno.Id_escuela
        alumno_new.save!
      end
    end
end
