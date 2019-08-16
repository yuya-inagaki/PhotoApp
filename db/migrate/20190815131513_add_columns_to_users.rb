class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :name, :string
    change_column :users, :name, :string, :null => false
    add_column :users, :profile, :string
    add_column :users, :image, :string
  end
end
