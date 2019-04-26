class AlumnoCompController < ApplicationController
  def index  
    @alum_comp_data = Alumno_comp.using(:data_warehouse).all.order(:Id_Alumno)
    export
  end
  
  private

  def export
    Alumno_comp.using(:data_warehouse).delete_all if !Alumno_comp.using(:data_warehouse).all.empty?

    @alum_comp_CA = Alumno_comp.using(:controlA).all 

    @alum_comp_CA.each do |detalle|
      alum_comp_new = Alumno_comp.using(:data_warehouse).new
      alum_comp_new.Id_Compet = detalle.Id_Compet
      alum_comp_new.Id_Alumno = detalle.Id_Alumno
      alum_comp_new.Oportunidad = detalle.Oportunidad
      alum_comp_new.Calificación = detalle.Calificación
      alum_comp_new.save!   
    end
  end
end
