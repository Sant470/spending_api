class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :employee_id, null: false
      t.string :name, null: false
      t.string :mobile_no
      t.string :email, null: false
      t.timestamps
    end
  end
end
