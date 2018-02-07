class AddReferenceMccCodeToTransction < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :mcc_code, index: true
    remove_reference :transactions, :card
    remove_columns :transactions, :mobile_no, :card_number, :merchant_name, :mcc_code
  end
end
