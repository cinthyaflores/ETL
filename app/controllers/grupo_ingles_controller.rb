class GrupoInglesController < ApplicationController
  def init
    export
  end

  def index
    @grupos_data = Grupo_Ingles.using(:data_warehouse).all
    export
  end

  private

    def export
      Grupo_Ingles.using(:data_warehouse).delete_all if !Grupo_Ingles.using(:data_warehouse).all.empty?

      @grupo_extra = Grupo_Ingles.using(:extra).all 

      @grupo_extra.each do |grupo|
        grupo_new = Grupo_Ingles.using(:data_warehouse).new
        grupo_new.Id_grupo_I = grupo.Id_grupo_I
        grupo_new.Id_nivel = grupo.Id_nivel
        grupo_new.Nombre = grupo.Nombre
        grupo_new.Cupo = grupo.Cupo
        grupo_new.Id_aula = grupo.Id_aula
        grupo_new.Dias = grupo.Id_dias
        grupo_new.Hora_inicio = grupo.Hora_inicio
        grupo_new.Hora_fin = grupo.Hora_fin
        grupo_new.save!
      end
    end
end
