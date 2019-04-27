class JustificanteController < ApplicationController
  def index  
    @justificantes_data = Justificante.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Justificante.using(:data_warehouse).delete_all if !Justificante.using(:data_warehouse).all.empty?

    @justificantes_ca = Justificante.using(:controlA).all 

    @justificantes_ca.each do |just|
      just_new = Justificante.using(:data_warehouse).new
      just_new.Id_Just = just.Id_Just
      just_new.Id_Alumno = just.Id_Alumno
      just_new.Id_Personal = just.Id_Personal
      just_new.Fecha_ini = just.Fecha_ini
      just_new.Fecha_fin = just.Fecha_fin
      just_new.Causa = just.Causa
      just_new.Fecha_elab = just.Fecha_elab
      just_new.save!   
    end
  end
end
