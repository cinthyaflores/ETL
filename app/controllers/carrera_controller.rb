# frozen_string_literal: true

class CarreraController < ApplicationController

  def init
    export
  end

  def index
    @carreras_data = Carrera.using(:data_warehouse).all
    export
    verify
  end

  def edit
    @carrera = Carrera.using(:data_warehouse).find_by(Id_Carrera: params[:id])
    @error = @carrera.errorNombre
  end

  def update
    @carrera = Carrera.using(:data_warehouse).find_by(Id_Carrera: params[:id])
    @error = @carrera.errorNombre

    if @carrera.update_attributes(Nombre: params[:carrera][:Nombre], errorNombre: nil)
      redirect_to "/carrera"
    else
      render :edit
    end
  end

  def destroy
    @carrera = Carrera.using(:data_warehouse).find_by(Id_Carrera: params[:id])
    @carrera.destroy
    redirect_to "/carrera"
  end

  def delete_table
    Carrera.using(:data_warehouse).where(errorNombre: 1).destroy_all
    redirect_to "/carrera"
  end

  private

    def verify
      @carreras_data.each do |carrera|
        if carrera.errorNombre
          @errores = true
        end
      end
    end

    def export
      Carrera.using(:data_warehouse).delete_all if !Carrera.using(:data_warehouse).all.empty?

      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @carreras_bi = @biblio.sheet("Carrera")
      @carreras_ca = Carrera.using(:controlA).all # Id_carrera, Nombre, Descripción, Creditos, Acreditada
      @carreras_e = Carrera.using(:extra).all # CAMPOS: Id_carrera, Nombre

      @carreras_ca.each do |carrera_ca|
        carrera_new = Carrera.using(:data_warehouse).new
        carrera_new.Id_Carrera = carrera_ca.Id_Carrera
        carrera_new.base = "c"
        @carreras_e.each do |carrera_e|
          if carrera_ca.Id_Carrera == carrera_e.Id_carrera
            carrera_new.Nombre = I18n.transliterate(carrera_e.Nombre)
            carrera_new.base = "e"
            if validate_name(carrera_new.Nombre)
              carrera_new.errorNombre = 1
            end
          end
        end
        carrera_new.Descripción = carrera_ca.Descripción
        carrera_new.Creditos = carrera_ca.Creditos
        carrera_new.Acreditada = carrera_ca.Acreditada
        carrera_new.save!
      end

      @carreras_bi.each_row_streaming(offset: 1) do |carreraB| # Ingresar los que no existen en Control Academico
        if @carreras_data.exists?(Id_Carrera: carreraB[0].value) == false
          carrera_new = Carrera.using(:data_warehouse).new
          carrera_new.Id_Carrera = carreraB[0].value
          carrera_new.Nombre = I18n.transliterate(carreraB[1].value)
          if validate_name(carrera_new.Nombre)
            carrera_new.errorNombre = 1
          end
          carrera_new.base = "b"
          carrera_new.save!
        end
      end

    end
end
