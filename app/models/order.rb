class Order < ApplicationRecord
	belongs_to :user

	monetize :amount_cents
	validates :ticket_sku, presence: true
  validates :amount, presence: true
  validates :user, presence: true
end
