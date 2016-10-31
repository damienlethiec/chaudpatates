class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :training

	validates :user_id, presence: true
	validates :training_id, presence: true

	scope :past, -> { joins(:training).merge(Training.past.order(:date)) }
	scope :upcoming, -> { joins(:training).merge(Training.upcoming.order(:date)) }
	scope :user_is, -> (user) { where(user: user) }
	scope :training, -> (training) { where( training: training) }
	
end
