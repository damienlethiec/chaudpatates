class Location < ApplicationRecord
	has_many :trainings

	ADDRESSLENGTH = 5..150

	validates :name, presence: true
	validates :photo, presence: true
	validates :address, presence: true, length: { in: ADDRESSLENGTH }

end
