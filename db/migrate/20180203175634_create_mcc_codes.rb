class CreateMccCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :mcc_codes do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
