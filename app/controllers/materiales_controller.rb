class MaterialesController < ApplicationController

  def init
    export
  end

  def empty
    return Materiales.using(:data_warehouse).all.empty?
  end

  def index
    @materiales_data = Materiales.using(:data_warehouse).all
  end

  def edit
    @material = Materiales.using(:data_warehouse).find_by(id_Material: params[:id])
    @errores = [@material.errorAutor, @material.errorExistencia]
  end

  def update
    @material = Materiales.using(:data_warehouse).find_by(id_Material: params[:id])
    @errores = [@material.errorAutor, @material.errorExistencia]
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - material ID #{params[:id]}: #{@material.autor} --> #{params[:materiales][:autor]}" if @error != nil

    if @material.update_attributes(autor: params[:materiales][:autor], errorAutor: nil, existencia: params[:materiales][:existencia], errorExistencia: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/materiales"
    else
      render :edit
    end
  end

  def destroy
    @recurso = Materiales.using(:data_warehouse).find_by(id_Material: params[:id])
    @recurso.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Material ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/materiales"
  end

  def delete_table
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros con errores - Materiales"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    Materiales.using(:data_warehouse).where(errorAutor: 1).destroy_all
    Materiales.using(:data_warehouse).where(errorExistencia: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @materiales_data = Materiales.using(:data_warehouse).all
    case c_user
    when 1
      @materiales_data.each do |material|
        if material.errorAutor || material.errorExistencia
          return true
        end
      end
    when 4
      @materiales_data.each do |material|
        if material.errorAutor || material.errorExistencia
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Materiales.using(:data_warehouse_final).delete_all if !Materiales.using(:data_warehouse_final).all.empty?

    recurso = Materiales.using(:data_warehouse).all
    Materiales.using(:data_warehouse_final).new
    recurso.each do |data|
      Materiales.using(:data_warehouse_final).create(id_Material: data.id_Material,
                                                     nombre: data.nombre, autor: data.autor,
                                                     existencia: data.existencia, id_Pais: data.id_Pais,
                                                     Id_idioma: data.Id_idioma, Tipo_Material: data.Tipo_Material,
                                                     Id_Estante: data.Id_Estante)
    end
  end

  def data
    actividades = Materiales.using(:data_warehouse).all
  end

  private

  def export
    Materiales.using(:data_warehouse).delete_all if !Materiales.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @materiales = @biblio.sheet("Materiales")
    
    @materiales.each_row_streaming(offset: 1) do |material|
      @material_new = Materiales.using(:data_warehouse).new
      @material_new.id_Material = material[0].value
      @material_new.nombre = material[1]
      @material_new.autor = material[2]
      @material_new.existencia = material[3].value
      @material_new.id_Pais = material[4].value
      @material_new.Id_idioma= material[5].value
      @material_new.Tipo_Material = material[6]
      @material_new.Id_Estante = material[7].value
      if validate_name(@material_new.autor)
        @material_new.errorAutor = 1
      end
      if !validate_weight(@material_new.existencia)
        @material_new.errorExistencia = 1
      end
      @material_new.save!
    end
  end
end
