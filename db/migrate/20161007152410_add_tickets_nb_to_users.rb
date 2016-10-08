class AddTicketsNbToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tickets_nb, :integer, default: 1
  end
end
