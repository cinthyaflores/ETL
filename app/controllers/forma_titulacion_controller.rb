class FormaTitulacionController < ApplicationController
  def index  
    @forma_titu_data = Forma_titulacion.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Forma_titulacion.using(:data_warehouse).delete_all if !Forma_titulacion.using(:data_warehouse).all.empty?

    @forma_titu_ca = Forma_titulacion.using(:controlA).all 

    @forma_titu_ca.each do |forma|
      forma_new = Forma_titulacion.using(:data_warehouse).new
      forma_new.Id_Form_Titu = forma.Id_Form_Titu
      forma_new.Nombre = forma.Nombre
      forma_new.save!   
    end
  end
end
