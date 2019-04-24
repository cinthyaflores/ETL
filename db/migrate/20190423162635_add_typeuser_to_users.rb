class AddTypeuserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tipo, :int
  end
end
