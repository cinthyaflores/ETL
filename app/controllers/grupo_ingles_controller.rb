class GrupoInglesController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Grupo_Ingles.using(:data_warehouse).all.empty?
  end

  def index
    @grupos_data = Grupo_Ingles.using(:data_warehouse).all
  end

  def export_to_sql
    Grupo_Ingles.using(:data_warehouse_final).delete_all if !Grupo_Ingles.using(:data_warehouse_final).all.empty?

    grupo_ing = Grupo_Ingles.using(:data_warehouse).all
    grupo_ing.each do |data|
      Grupo_Ingles.using(:data_warehouse_final).create(
        Id_grupo_I: data.Id_grupo_I, Id_nivel: data.Id_nivel, 
        Nombre: data.Nombre,Cupo: data.Cupo, Id_aula: data.Id_aula, 
        Dias: data.Dias, Hora_inicio: data.Hora_inicio, 
        Hora_fin: data.Hora_fin)
    end
  end
  
  def data 
    grupo = Grupo_Ingles.using(:data_warehouse).all
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
        grupo_new.Hora_inicio = grupo.Hora_inicio.to_s
        grupo_new.Hora_fin = grupo.Hora_fin.to_s
        grupo_new.save!
      end
    end
end
