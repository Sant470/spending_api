class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :mobile_no, null: false
      t.string :employee_id, null: false
      t.integer :card_number, null: false
      t.string :merchant_name, null: false
      t.datetime :transaction_time, null:false
      t.integer :amount, null: false
      t.boolean :status, null: false
      t.string :mcc_code, null:false
      t.references :employee, foreign_key: true, null: false
      t.references :card, foreign_key: true, null: false
      t.timestamps
    end
  end
end
