class MaestroGrupoActividadesController < ApplicationController
  def init
    export
  end

  def index
    @maestros_data = Maestro_grupo_actividades.using(:data_warehouse).all
    export
  end

  private

    def export
      Maestro_grupo_actividades.using(:data_warehouse).delete_all if !Maestro_grupo_actividades.using(:data_warehouse).all.empty?

      @maestros_extra = Maestro_grupo_actividades.using(:extra).all 

      @maestros_extra.each do |maestro|
        maestro_new = Maestro_grupo_actividades.using(:data_warehouse).new
        maestro_new.Id_Maestro = find_id_maestro(maestro.Id_maestro)
        maestro_new.Id_grupo_Ac = maestro.Id_grupo_A
        maestro_new.Id_periodo = maestro.Id_periodo
        maestro_new.save!
      end
    end
end
