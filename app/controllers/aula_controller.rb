class AulaController < ApplicationController
  def index  
    @aulas_data = Aula.using(:data_warehouse).all
    export
  end
  
  private

  def export
    Aula.using(:data_warehouse).delete_all if !Aula.using(:data_warehouse).all.empty?

    @aulas_ca = Aula.using(:controlA).all 
    @aulas_e= Aula.using(:extra).all 
    id_aula = 0
    @aulas_ca.each do |aula_c|
      aula_new = Aula.using(:data_warehouse).new
      if aula_c.Nombre.start_with?("IN") #Pasar los datos que coincidan entre Control y Extraescolares
        id_aula += 1
        @aulas_e.each do |aula_e|
          if aula_c.Nombre.scan(/\d+/) == aula_e.Id_aula_extra.scan(/\d+/)
            aula_new.Id_Aula = id_aula
            aula_new.Nombre = aula_e.Id_aula_extra
            aula_new.Edificio = "Inglés"
            aula_new.Descripcion = aula_e.Descripcion
          end
        end
      else
        aula_new.Id_Aula = aula_c.Id_Aula
        aula_new.Nombre = aula_c.Nombre
        aula_new.Edificio = aula_c.Edificio
        id_aula = aula_c.Id_Aula
      end
      aula_new.save!  
      if @aulas_ca.last.Nombre == aula_c.Nombre  
        add_extra(aula_c.Nombre.scan(/\d+/).first, id_aula)
      end 
    end
  end
end

def add_extra(num, id_aula) #Extraescolares tiene registradas más aulas que Control. Se agregan las que faltan
  @aulas_e.each do |aula_e| 
    puts aula_e.Id_aula_extra.scan(/\d+/).first
    puts num
    if aula_e.Id_aula_extra.scan(/\d+/).first.to_i > num.to_i
      id_aula += 1
      aula_new = Aula.using(:data_warehouse).new
      aula_new.Id_Aula = id_aula
      aula_new.Nombre = aula_e.Id_aula_extra
      aula_new.Edificio = "Ingles"
      aula_new.Descripcion = aula_e.Descripcion
      aula_new.save!
    end
  end
end
