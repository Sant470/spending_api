class CreateCardTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :card_types do |t|
      t.integer :type, null: false
      t.timestamps
    end
  end
end
