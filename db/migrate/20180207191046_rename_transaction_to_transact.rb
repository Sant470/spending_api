class RenameTransactionToTransact < ActiveRecord::Migration[5.1]
  def change
    rename_table :transactions, :transacts
  end
end
