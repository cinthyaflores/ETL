class LibrosController < ApplicationController

  def init
    export 
  end

  def empty
    return Libro.using(:data_warehouse).all.empty?
  end

  def index
    @libros_data = Libro.using(:data_warehouse).all
  end

  def edit 
    @libro = Libro.using(:data_warehouse).find_by(idLibro: params[:id])
    @error = @libro.errorISBN
  end

  def update 
    @libro = Libro.using(:data_warehouse).find_by(idLibro: params[:id])
    @error = @libro.errorISBN
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Actualizó - Libros ID #{params[:id]}: ISBN" 

    if @libro.update_attributes(ISBN: params[:libro][:ISBN], errorISBN: nil)
      User_logins.using(:data_warehouse).all
      User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
      redirect_to "/libros"
    else
      render :edit
    end
  end

  def destroy 
    @libros = Libro.using(:data_warehouse).find_by(idLibro: params[:id])
    @libros.destroy
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó registró - Libro ID: #{params[:id]}"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    redirect_to "/libros"
  end

  def delete_table 
    usuario = current_user.email
    fecha = DateTime.now.strftime("%d/%m/%Y %T")
    campo_modificado = "Eliminó todos los registros - Libros"
    User_logins.using(:data_warehouse).create(usuario: usuario, fecha: fecha, modificacion: campo_modificado)
    
    Libro.using(:data_warehouse).where(errorISBN: 1).destroy_all
    redirect_to "/show_tables"
  end

  def verify(c_user)
    @libros = Libro.using(:data_warehouse).all
    case c_user
    when 1
      @libros.each do |libro|
        if libro.errorISBN
          return true
        end
      end
    when 4
      @libros.each do |libro|
        if libro.errorISBN
          return true
        end
      end
    end
    return false
  end

  def export_to_sql
    Libro.using(:data_warehouse_final).delete_all if !Libro.using(:data_warehouse_final).all.empty?

    libros = Libro.using(:data_warehouse).all
    Libro.using(:data_warehouse_final).new
    libros.each do |data|
      Libro.using(:data_warehouse_final).create(idLibro: data.idLibro,
        edicion: data.edicion, aPublicacion: data.aPublicacion, ISBN: data.ISBN, id_Editorial: data.id_Editorial)
    end
  end
  
  def data 
    libros = Libro.using(:data_warehouse).all
  end

  private

  def export
    Libro.using(:data_warehouse).delete_all if !Libro.using(:data_warehouse).all.empty?

    @biblio = Roo::Spreadsheet.open("./public/Biblioteca.xlsx")
    @libros_b = @biblio.sheet("Libro")

    @libros_b.each_row_streaming(offset: 1) do |libro|
      libro_new = Libro.using(:data_warehouse).new
      libro_new.idLibro = libro[0]
      libro_new.edicion = libro[1].value
      libro_new.aPublicacion = libro[2].value
      libro_new.ISBN = libro[3]
      if !validate_ISBN(libro_new.ISBN)
        libro_new.errorISBN=1
      end
      libro_new.id_Editorial = libro[4].value
      libro_new.save!
    end
  end
end
