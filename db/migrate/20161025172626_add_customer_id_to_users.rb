class AddCustomerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :customer_id, :integer
  end
end
