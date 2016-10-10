class Location < ApplicationRecord
	has_many :trainings, dependent: :destroy

	ADDRESSLENGTH = 5..150

	validates :name, presence: true
	validates :photo, presence: true
	validates :address, presence: true, length: { in: ADDRESSLENGTH }

	has_attachment :photo
end
