class CreateFinancialYears < ActiveRecord::Migration[5.1]
  def change
    create_table :financial_years do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
  end
end
