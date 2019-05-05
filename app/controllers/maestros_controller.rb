# frozen_string_literal: true

class MaestrosController < ApplicationController

  def init
    export
  end

  def empty
    return Alumno.using(:data_warehouse).all.empty?
  end

  def index
    @maestrosData = Maestro.using(:data_warehouse).all
  end

  def edit
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @errores = [@maestro.errorNombre, @maestro.errorTelefono, @maestro.errorCorreo]
  end

  def update
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    @errores = [@maestro.errorNombre, @maestro.errorTelefono, @maestro.errorCorreo]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campos_modificados = Array.new
    campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Nombre") if @errores[0] != nil
    campos_modificados.push("Actualizó Alumno ID #{params[:id]}: Teléfono") if @errores[1] != nil
    campos_modificados.push("Actualizó Maestro ID #{params[:id]}: Correo") if @errores[2] != nil
    if @maestro.update_attributes(Id_maestro: params[:maestro][:Id_maestro], Nombre: params[:maestro][:Nombre], Telefono: params[:maestro][:Telefono],CorreoElec: params[:maestro][:CorreoElec], errorNombre: nil, errorTelefono: nil, errorCorreo: nil)
      User_logins.using(:data_warehouse).all
      campos_modificados.each do |campo|
        User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo)
      end
      redirect_to "/maestros"
    else
      render :edit
    end
  end

  def destroy
    @maestro = Maestro.using(:data_warehouse).find_by(Id_maestro: params[:id])
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Maestro ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    @maestro.destroy
    redirect_to "/maestros"
  end

  def delete_table
    case current_user.tipo 
    when 1
      Maestro.using(:data_warehouse).where(errorNombre: 1).delete_all
      Maestro.using(:data_warehouse).where(errorTelefono: 1).delete_all
      Maestro.using(:data_warehouse).where(errorCorreo: 1).delete_all
    when 2
      Maestro.using(:data_warehouse).where(errorNombre: 1, base: "c").delete_all
      Maestro.using(:data_warehouse).where(errorTelefono: 1, base: "c").delete_all
      Maestro.using(:data_warehouse).where(errorCorreo: 1, base: "c").delete_all
    when 3
      Maestro.using(:data_warehouse).where(errorNombre: 1, base: "e").delete_all
      Maestro.using(:data_warehouse).where(errorTelefono: 1, base: "e").delete_all
      Maestro.using(:data_warehouse).where(errorCorreo: 1, base: "e").delete_all
    when 4
      Maestro.using(:data_warehouse).where(errorNombre: 1, base: "b").delete_all
      Maestro.using(:data_warehouse).where(errorTelefono: 1, base: "b").delete_all
      Maestro.using(:data_warehouse).where(errorCorreo: 1, base: "b").delete_all
    end
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Maestro"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado) 
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @maestrosData = Maestro.using(:data_warehouse).all
    case c_user
    when 1
      @maestrosData.each do |maestro|
        if maestro.errorNombre || maestro.errorTelefono || maestro.errorCorreo
          return true
        end
      end
    when 2
      @maestrosData.each do |maestro|
        if (maestro.errorNombre || maestro.errorTelefono|| maestro.errorCorreo) && maestro.base == "c"
          return true
        end
      end
    when 3
      @maestrosData.each do |maestro|
        if (maestro.errorNombre || maestro.errorTelefono|| maestro.errorCorreo) && maestro.base == "e"
          return true
        end
      end
    when 4
      @maestrosData.each do |maestro|
        if (maestro.errorNombre || maestro.errorTelefono|| maestro.errorCorreo) && maestro.base == "b"
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Maestro.using(:data_warehouse_final).delete_all if !Maestro.using(:data_warehouse_final).all.empty?
    
    maestros_bien = Maestro.using(:data_warehouse).all.order(:Id_maestro)
    Maestro.using(:data_warehouse_final).new
    maestros_bien.each do |data|
      Maestro.using(:data_warehouse_final).create(Id_maestro: data.Id_maestro, Id_Area_mtro: data.Id_Area_mtro, Id_contrato: data.Id_contrato, Nombre: data.Nombre, CorreoElec: data.CorreoElec, Telefono: data.Telefono, Titulo: data.Titulo, Clave: data.Clave)
    end
  end
  
  def data 
    Maestro.using(:data_warehouse).new
    maestros_bien = Maestro.using(:data_warehouse).all.order(:Id_maestro)
  end

  private

    def export
      Maestro.using(:data_warehouse).delete_all
      id_m = 0

      Maestro.using(:data_warehouse).new
      @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
      @maestrosB = @biblio.sheet("Maestros")
      @maestrosCA = Maestro.using(:controlA).all
      @maestrosE = Maestro.using(:extra).all

      @maestrosCA.each do |maestroCA|
        maestroNew = Maestro.using(:data_warehouse).new
        if validate_name(maestroCA.Nombre)
          maestroNew.errorNombre = 1
        end
        if !validate_number(maestroCA.Telefono)
          maestroNew.errorTelefono = 1
        end
        if !validate_email(maestroCA.CorreoElec)
          maestroNew.errorCorreo = 1
        end
        id_m += 1
        maestroNew.Id_maestro = maestroCA.Id_maestro
        maestroNew.Id_Area_mtro = maestroCA.Id_Area_mtro
        maestroNew.Id_contrato = maestroCA.Id_contrato
        maestroNew.Nombre = maestroCA.Nombre
        maestroNew.CorreoElec = maestroCA.CorreoElec
        maestroNew.Telefono = maestroCA.Telefono
        maestroNew.Titulo = maestroCA.Titulo
        maestroNew.base = "c"
        maestroNew.save!
      end

      @maestrosE.each do |maestroE|
        maestroNew = Maestro.using(:data_warehouse).new
        if validate_name(maestroE.Nombre)
          maestroNew.errorNombre = 1
        end
        if !validate_number(maestroE.Telefono)
          maestroNew.errorTelefono = 1
        end
        if !validate_email(maestroE.Correo)
          maestroNew.errorCorreo = 1
        end
        id_m += 1
        maestroNew.Id_maestro = id_m
        maestroNew.Id_Area_mtro = area_maestro(maestroE.TipoMaestro)
        maestroNew.Clave = maestroE.Id_maestro_extra
        maestroNew.Nombre = maestroE.Nombre
        maestroNew.CorreoElec = maestroE.Correo
        maestroNew.Telefono = maestroE.Telefono
        maestroNew.base = "e"
        maestroNew.save!
      end

      @maestrosData = Maestro.using(:data_warehouse).all
      @maestrosB.each_row_streaming(offset: 1) do |maestroB| # Ingresar los que no existen en Control Academico
        if @maestrosData.exists?(Id_maestro: maestroB[0].value) == false
          maestroNew = Maestro.using(:data_warehouse).new
          maestroNew.Id_maestro = maestroB[0].value
          maestroNew.Id_Area_mtro = maestroB[1].value
          maestroNew.base = "b"
          maestroNew.save!
        end
      end

    end

end
