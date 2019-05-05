class MaestroGrupoInglesController < ApplicationController
  
  def init
    export
  end
  
  def empty
    return Maestro_grupo_ingles.using(:data_warehouse).all.empty?
  end

  def index
    @maestros_data = Maestro_grupo_ingles.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Maestro_grupo_ingles.using(:data_warehouse_final).delete_all if !Maestro_grupo_ingles.using(:data_warehouse_final).all.empty?
    maestros = Maestro_grupo_ingles.using(:data_warehouse).all
    
    Maestro_grupo_ingles.using(:data_warehouse_final).new
    maestros.each do |maestro|
      Maestro_grupo_ingles.using(:data_warehouse_final).all
      maestro_new = Maestro_grupo_ingles.using(:data_warehouse_final).new
      maestro_new.Id_maestro = maestro.Id_maestro
      maestro_new.Id_grupo_I = maestro.Id_grupo_I
      maestro_new.Id_periodo = maestro.Id_periodo
      maestro_new.save!
    end
  end
  
  def data 
    maestros = Maestro_grupo_ingles.using(:data_warehouse).all
  end

  private

    def export
      Maestro_grupo_ingles.using(:data_warehouse).delete_all if !Maestro_grupo_ingles.using(:data_warehouse).all.empty?

      @maestros_extra = Maestro_grupo_ingles.using(:extra).all 
      @maestros_extra.each do |maestro|
        maestro_new = Maestro_grupo_ingles.using(:data_warehouse).new
        maestro_new.Id_maestro = find_id_maestro(maestro.Id_maestro_extra)
        m = find_id_maestro(maestro.Id_maestro_extra)
        maestro_new.Id_grupo_I = maestro.Id_grupo_I
        maestro_new.Id_periodo = maestro.Id_periodo
        maestro_new.save!
      end
    end
end
