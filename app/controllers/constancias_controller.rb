class ConstanciasController < ApplicationController
  def index  
    @constancias_data = Constancia.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Constancia.using(:data_warehouse).delete_all if !Constancia.using(:data_warehouse).all.empty?

    @constancias_ca = Constancia.using(:controlA).all 

    @constancias_ca.each do |constancia|
      const_new = Constancia.using(:data_warehouse).new
      const_new.Id_Const = constancia.Id_Const
      const_new.Id_Alumno = constancia.Id_Alumno
      const_new.Id_Personal = constancia.Id_Personal
      const_new.Id_Tipo_Con = constancia.Id_Tipo_Con
      const_new.Fecha_elab = constancia.Fecha_elab
      const_new.save!   
    end
  end
end
