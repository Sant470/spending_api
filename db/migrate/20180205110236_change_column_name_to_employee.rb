class ChangeColumnNameToEmployee < ActiveRecord::Migration[5.1]
  def change
    rename_column :employees, :employee_id, :uniqe_id
  end
end
