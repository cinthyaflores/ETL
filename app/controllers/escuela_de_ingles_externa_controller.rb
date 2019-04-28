class EscuelaDeInglesExternaController < ApplicationController
  def index
    @escuelas_data = Escuela_de_ingles_externa.using(:data_warehouse).all
    export
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
