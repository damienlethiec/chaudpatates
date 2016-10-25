class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :training

	validates :user_id, presence: true
	validates :training_id, presence: true

	scope :past, -> { where("start_date < ?", Date.today) }
	scope :upcoming, -> { where("start_date >= ?", Date.today) }
	scope :user_is, -> (user) { where(user: user) }
	scope :training, -> (training) { where( training: training) }
	
end
