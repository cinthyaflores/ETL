class AdeudosController < ApplicationController

  def init
    export 
  end

  def index
    @adeudos_data = Adeudos.using(:data_warehouse).all
    export
    verify
  end

  def edit 
    @adeudo = Adeudos.using(:data_warehouse).find_by(id_Adeudos: params[:id])
  end

  def update 
    @adeudo = Adeudos.using(:data_warehouse).find_by(id_Adeudos: params[:id])
    @error = @adeudo.errorCargo
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Adeudos ID #{params[:id]}: #{@adeudo.Cargo_Dia} --> #{params[:adeudos][:Cargo_Dia]}" if @error != nil

    if @adeudo.update_attributes(Cargo_Dia: params[:adeudos][:Cargo_Dia], errorCargo: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/"
    else
      render :edit
    end
  
  end

  def destroy 
    @adeudo = Adeudos.using(:data_warehouse).find_by(id_Adeudos: params[:id])
    @adeudo.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Adeudos ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Adeudos"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Adeudos.using(:data_warehouse).where(errorCargo: 1).destroy_all
    redirect_to "/"
  end

  private

  def verify
    @adeudos_data.each do |adeudo|
      if adeudo.errorCargo
        @errores = true
      end
    end
  end

  def export
    Adeudos.using(:data_warehouse).delete_all if !Adeudos.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    adeudos_biblio = @biblio.sheet("Adeudos")

    adeudos_biblio.each_row_streaming(offset: 1) do |adeudo| # Ingresar los que no existen en Control Academico
      adeudo_new = Adeudos.using(:data_warehouse).new
      adeudo_new.id_Adeudos = adeudo[0].value
      adeudo_new.id_Prestamo = adeudo[1]
      adeudo_new.Cargo_Dia = adeudo[2].value
      if !validate_weight(adeudo_new.Cargo_Dia)
        adeudo_new.errorCargo = 1
      end
      adeudo_new.save!
    end
  end
end
