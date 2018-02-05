class CreateSpendings < ActiveRecord::Migration[5.1]
  def change
    create_table :spendings do |t|
      t.integer :amount, null: false
      t.references :transaction, foreign_key: true, null: false
      t.references :months_limit, foreign_key: true, null: false
      t.references :employee, foreign_key: true, null: false
      t.timestamps
    end
  end
end
