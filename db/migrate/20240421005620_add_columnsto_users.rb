class AddColumnstoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :zip_code, :string
    add_column :users, :address, :string
    add_column :users, :profile, :string
  end
end