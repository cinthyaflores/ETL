class SoftwareController < ApplicationController
  def index
    @software_data = Software.using(:data_warehouse).all
    export
  end

  private

  def export
    Software.using(:data_warehouse).delete_all if !Software.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @software_b = @biblio.sheet("Software")

    @software_b.each_row_streaming(offset: 1) do |soft|
      @soft_new = Software.using(:data_warehouse).new
      @soft_new.idSoftware = soft[0]
      if soft[1].value.is_a? Integer
        @soft_new.version = soft[1].value 
      else
        @soft_new.version = soft[1].value.round(1) 
      end
      @soft_new.ann_salida = soft[2].value
      @soft_new.save!
    end
  end
end
