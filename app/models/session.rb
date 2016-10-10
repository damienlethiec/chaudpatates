class Session < ApplicationRecord
  belongs_to :city

  enum day: [:lundi, :mardi, :mercredi, :jeudi, :vendredi, :samedi, :dimanche]

  validates :day, presence: true, inclusion: { in: days }
  validates :time_of_day, presence: true
  validates :city_id, presence: true
end
