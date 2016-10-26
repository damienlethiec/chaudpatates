class TicketsPackage < ApplicationRecord
	monetize :price_cents
	validates :sku, presence: true
  validates :price, presence: true
  validates :tickets_nb, presence: true
end
