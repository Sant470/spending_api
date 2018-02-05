class CreateMonthsLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :months_limits do |t|
      t.integer :month, null: false
      t.integer :limit, null: false
      t.references :mcc_code, foreign_key: true, null:false
      t.references :financial_year, foreign_key: true, null:false
      t.timestamps
    end
  end
end
