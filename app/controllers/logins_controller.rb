class LoginsController < ApplicationController

  def index
    logins = User_logins.using(:data_warehouse).all
  end

  def export_to_sql
    User_logins.using(:data_warehouse_final).delete_all if !User_logins.using(:data_warehouse_final).all.empty?

    logins = User_logins.using(:data_warehouse).all
    logins.each do |data|
      User_logins.using(:data_warehouse_final).create(Id_login: data.Id_login,
        usuario: data.usuario, modificacion: data.modificacion, 
        fecha: data.fecha)
    end
  end
  
  def data 
    logins = User_logins.using(:data_warehouse).all
  end

end
