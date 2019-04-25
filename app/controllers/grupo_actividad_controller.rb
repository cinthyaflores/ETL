class GrupoActividadController < ApplicationController
  def index
    @gruposE = Grupo_actividad.using(:extra).all #CAMPOS: Id_grupo_A, Nombre, Cupo, Id_Area, Id_Actividad, Dias, Hora_inicio, Hora_fin

    @cupoErrorsE = Array.new #ERRORES EN CARRERA

    @gruposE.each do |grupo|
      if !validate_weight(grupo.Cupo)
        @cupoErrorsE << grupo
      end
    end
  end

  def edit
  end

  def update
  end

  def delete
  end
end
