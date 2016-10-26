class ChangeDataTypeForCustomerId < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :customer_id,  :string
  end
end
