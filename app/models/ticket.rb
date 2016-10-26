class Ticket < ApplicationRecord
	monetize :price_cents
	validates :sku, presence: true
  validates :price, presence: true
end
