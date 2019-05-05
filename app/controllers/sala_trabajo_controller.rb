class SalaTrabajoController < ApplicationController

  def init
    export
  end
  
  def empty
    return Sala_trabajo.using(:data_warehouse).all.empty?
  end

  def index
    @salas_data = Sala_trabajo.using(:data_warehouse).all
    export
  end

  def export_to_sql
    Sala_trabajo.using(:data_warehouse_final).delete_all if !Sala_trabajo.using(:data_warehouse_final).all.empty?

    salas = Sala_trabajo.using(:data_warehouse).all
    salas.each do |data|
      Sala_trabajo.using(:data_warehouse_final).create(
        Id_salon: data.Id_salon, Clave: data.Clave, 
        Capacidad: data.Capacidad)
    end
  end
  
  def data 
    actividades = Sala_trabajo.using(:data_warehouse).all
  end

  private

  def export
    Sala_trabajo.using(:data_warehouse).delete_all if !Sala_trabajo.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @salas_b = @biblio.sheet("Sala_Trabajo")

    @salas_b.each_row_streaming(offset: 1) do |sala|
      sala_new = Sala_trabajo.using(:data_warehouse).new
      sala_new.Id_salon = sala[0].value
      sala_new.Clave = sala[1]
      sala_new.Capacidad = sala[2].value
      sala_new.save!
    end
  end
end
