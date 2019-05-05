# frozen_string_literal: true

class CarreraController < ApplicationController

  def init
    export
  end

  def empty
    return Adeudos.using(:data_warehouse).all.empty?
  end

  def index
    @carreras_data = Carrera.using(:data_warehouse).all
  end

  def edit
    @carrera = Carrera.using(:data_warehouse).find_by(Id_Carrera: params[:id])
    @errores = [@carrera.errorNombre, @carrera.errorCreditos]
  end

  def update
    @carrera = Carrera.using(:data_warehouse).find_by(Id_Carrera: params[:id])
    @errores = [@carrera.errorNombre, @carrera.errorCreditos]

    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    if @carrera.errorNombre == 1 && @carrera.errorCreditos == 1
      campo_modificado = "Actualizó - Carrera ID #{params[:id]}: Nombre y Créditos"
    elsif @carrera.errorCreditos == 1
      campo_modificado = "Actualizó - Carrera ID #{params[:id]}: Créditos"
    else
      campo_modificado = "Actualizó - Carrera ID #{params[:id]}: Nombre"
    end

    if @carrera.update_attributes(Nombre: params[:carrera][:Nombre], Creditos: params[:carrera][:Creditos], errorNombre: nil, errorCreditos: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/carrera"
    else
      render :edit
    end

  end

  def destroy
    @carrera = Carrera.using(:data_warehouse).find_by(Id_Carrera: params[:id])
    @carrera.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Carrera ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/carrera"
  end

  def delete_table
    case current_user.tipo
    when 1 
      Carrera.using(:data_warehouse).where(errorNombre: 1).destroy_all
      Carrera.using(:data_warehouse).where(errorCreditos: 1).destroy_all
    when 2
      Carrera.using(:data_warehouse).where(errorNombre: 1, base: "c").destroy_all
      Carrera.using(:data_warehouse).where(errorCreditos: 1, base: "c").destroy_all
    when 3
      Carrera.using(:data_warehouse).where(errorNombre: 1, base: "e").destroy_all
      Carrera.using(:data_warehouse).where(errorCreditos: 1, base: "e").destroy_all
    when 4
      Carrera.using(:data_warehouse).where(errorNombre: 1, base: "b").destroy_all
      Carrera.using(:data_warehouse).where(errorCreditos: 1, base: "b").destroy_all
    end
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Carrera"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @carreras_data = Carrera.using(:data_warehouse).all
    case c_user
    when 1
      @carreras_data.each do |carrera|
        if carrera.errorNombre || carrera.errorCreditos
          return true
        end
      end
    when 2 
      @carreras_data.each do |carrera|
        if carrera.errorNombre || carrera.errorCreditos && carrera.base == "c"
          return true
        end
      end
    when 3
      @carreras_data.each do |carrera|
        if carrera.errorNombre && carrera.base == "e"
          return true
        end
      end
    when 4
      @carreras_data.each do |carrera|
        if carrera.errorNombre && carrera.base == "b"
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Carrera.using(:data_warehouse_final).delete_all if !Carrera.using(:data_warehouse_final).all.empty?

    carreras = Carrera.using(:data_warehouse).all
    Carrera.using(:data_warehouse_final).new
    carreras.each do |data|
      Carrera.using(:data_warehouse_final).create(Id_Carrera: data.Id_Carrera,
      Nombre: data.Nombre, Descripción: data.Descripción, Creditos: data.Creditos, Acreditada: data.Acreditada)
    end

  end
  
  def data 
    actividades = Carrera.using(:data_warehouse).all
  end

  private

    def export
      Carrera.using(:data_warehouse).delete_all if !Carrera.using(:data_warehouse).all.empty?

      @carreras_ca = Carrera.using(:controlA).all # Id_carrera, Nombre, Descripción, Creditos, Acreditada
      @carreras_e = Carrera.using(:extra).all # CAMPOS: Id_carrera, Nombre

      id_c = 1
      @carreras_ca.each do |carrera_ca|
        carrera_new = Carrera.using(:data_warehouse).new
        carrera_new.Id_Carrera = carrera_ca.Id_Carrera
        carrera_new.base = "c"
        carrera_new.Nombre = carrera_ca.Nombre
        if validate_name(carrera_new.Nombre)
          carrera_new.errorNombre = 1
        end
        carrera_new.Descripción = carrera_ca.Descripción
        carrera_new.Creditos = carrera_ca.Creditos
        if !validate_weight(carrera_new.Creditos)
          carrera_new.errorCreditos = 1
        end
        carrera_new.Acreditada = carrera_ca.Acreditada
        carrera_new.save!
        id_c += 1
      end

      @carreras_e.each do |carrera_e|
        carrera_new = Carrera.using(:data_warehouse).new
        carrera_new.Id_Carrera = id_c
        carrera_new.Nombre = I18n.transliterate(carrera_e.Nombre)
        carrera_new.base = "e"
        if validate_name(carrera_new.Nombre)
          carrera_new.errorNombre = 1
        end
        carrera_new.save!
        id_c += 1
      end

      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @carreras_bi = @biblio.sheet("Carrera")

      @carreras_data = Carrera.using(:data_warehouse).all
      @carreras_bi.each_row_streaming(offset: 1) do |carreraB|
        carrera_new = Carrera.using(:data_warehouse).new
        carrera_new.Id_Carrera = id_c
        carrera_new.Nombre = carreraB[1].value
        if validate_name(carrera_new.Nombre)
          carrera_new.errorNombre = 1
        end
        carrera_new.base = "b"
        carrera_new.save!
        id_c += 1
      end

    end

  end

    
