class DiasController < ApplicationController

  def init
    export
  end
  
  def empty
    return Dias.using(:data_warehouse).all.empty?
  end

  def index
    @dias_data = Dias.using(:data_warehouse).all
  end

  def export_to_sql
    Dias.using(:data_warehouse_final).delete_all if !Dias.using(:data_warehouse_final).all.empty?

    dias = Dias.using(:data_warehouse).all
    dias.each do |data|
      Dias.using(:data_warehouse_final).create(Id_dias: data.Id_dias,
        Descripcion: data.Descripcion)
    end
  end
  
  def data 
    dias = Dias.using(:data_warehouse).all
  end

  private

    def export
      Dias.using(:data_warehouse).delete_all if !Dias.using(:data_warehouse).all.empty?

      @dias_extra = Dias.using(:extra).all

      @dias_extra.each do |dia|
        dia_new = Dias.using(:data_warehouse).new
        dia_new.Id_dias = dia.Id_dias
        dia_new.Descripcion = dia.Dias
        dia_new.save!
      end
    end
end
