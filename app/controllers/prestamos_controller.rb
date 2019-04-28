class PrestamosController < ApplicationController
  def init
    export
  end

  def index
    @prestamos_data = Prestamos.using(:data_warehouse).all
    export
  end

  private

    def export
      Prestamos.using(:data_warehouse).delete_all if !Prestamos.using(:data_warehouse).all.empty?

      @prestamos_extra = Prestamos.using(:extra).all 

      @prestamos_extra.each do |prestamo|
        prestamo_new = Prestamos.using(:data_warehouse).new
        prestamo_new.Id_maestro_ex = find_id_maestro(prestamo.Id_maestro)
        prestamo_new.Id_prestamo = prestamo.Id_prestamo
        prestamo_new.Id_periodo = prestamo.Id_periodo
        prestamo_new.Fechaprestamo = prestamo.Fechaprestamo
        prestamo_new.Fechaentrega = prestamo.Fechaentrega
        prestamo_new.Estado = prestamo.Estado
        prestamo_new.save!
      end
    end
end
