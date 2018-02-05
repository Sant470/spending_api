class CreateCardTypeMccCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :card_type_mcc_codes do |t|
      t.references :card_type,foreign_key: true, null: false
      t.references :mcc_code,foreign_key: true, null: false
      t.timestamps
    end
  end
end
