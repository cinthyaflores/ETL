class EscuelaDeInglesExternaController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Escuela_de_ingles_externa.using(:data_warehouse).all.empty?
  end
  
  def index
    @escuelas_data = Escuela_de_ingles_externa.using(:data_warehouse).all
  end

  def export_to_sql
    Escuela_de_ingles_externa.using(:data_warehouse_final).delete_all if !Escuela_de_ingles_externa.using(:data_warehouse_final).all.empty?

    escuelas = Escuela_de_ingles_externa.using(:data_warehouse).all
    escuelas.each do |data|
      Escuela_de_ingles_externa.using(:data_warehouse_final).create(Id_escuela: data.Id_escuela,
        Nombre: data.Nombre)
    end
  end
  
  def data 
    escuelas = Escuela_de_ingles_externa.using(:data_warehouse).all
  end

  private

    def export
      Escuela_de_ingles_externa.using(:data_warehouse).delete_all if !Escuela_de_ingles_externa.using(:data_warehouse).all.empty?

      @escuelas_extra = Escuela_de_ingles_externa.using(:extra).all

      @escuelas_extra.each do |escu|
        escu_new = Escuela_de_ingles_externa.using(:data_warehouse).new
        escu_new.Id_escuela = escu.Id_escuela
        escu_new.Nombre = escu.Nombre
        escu_new.save!
      end
    end
end
