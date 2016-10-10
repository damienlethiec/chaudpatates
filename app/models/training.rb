class Training < ApplicationRecord
  belongs_to :city
  belongs_to :location
  has_many :bookings, dependent: :destroy

  validates :city_id, presence: true
  validates :date, presence: true

  has_attachment :photo

  def to_s
    "#{self.date}, #{self.city.name}"
  end
end
