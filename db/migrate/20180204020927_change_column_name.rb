class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :card_types, :type, :category
  end
end
