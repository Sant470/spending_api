class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :card_number, null: false
      t.date :expire_date, null: false
      t.integer :ccv, null: false
      t.references :card_type, foreign_key: true, null: false
      t.references :employee, foreign_key: true
      t.timestamps
    end
  end
end
