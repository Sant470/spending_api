class ChangeEmployeeIdToUniqueId < ActiveRecord::Migration[5.1]
  def change
    rename_column :employees, :employee_id, :unique_id
  end
end
