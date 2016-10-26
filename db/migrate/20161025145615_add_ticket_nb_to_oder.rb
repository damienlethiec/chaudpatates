class AddTicketNbToOder < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :tickets_nb, :integer, default: 10
  end
end
