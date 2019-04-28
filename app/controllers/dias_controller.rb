class DiasController < ApplicationController
  def index
    @dias_data = Dias.using(:data_warehouse).all
    export
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
