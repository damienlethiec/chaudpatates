class Session < ApplicationRecord
  belongs_to :city

  DAYS = 1..7

  validates :day, presence: true, inclusion: { in: DAYS }
  validates :time_of_day, presence: true
  validates :city_id, presence: true
end
