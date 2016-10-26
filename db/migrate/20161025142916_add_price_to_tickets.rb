class AddPriceToTickets < ActiveRecord::Migration[5.0]
  def change
  	add_monetize :tickets, :price, currency: { present: false }
  end
end
