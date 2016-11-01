class Location < ApplicationRecord
	has_many :trainings

	ADDRESSLENGTH = 5..150

	scope :city, -> (city) { where("lower(address) LIKE ?", "%#{city.name.downcase}%") }

	validates :name, presence: true
	validates :photo, presence: true
	validates :address, presence: true, length: { in: ADDRESSLENGTH }

	has_attachment :photo
end
