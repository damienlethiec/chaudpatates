class AddUserToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :user, foreign_key: true
  end
end
