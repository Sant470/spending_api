class AddPasswordHashToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :password_digest, :string
    add_column :employees, :admin, :boolean, default: false
  end
end
