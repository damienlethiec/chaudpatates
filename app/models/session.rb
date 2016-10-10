class Session < ApplicationRecord
  belongs_to :city

  enum day: [:Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday, :Sunday]

  validates :day, presence: true, inclusion: { in: days }
  validates :time_of_day, presence: true
  validates :city_id, presence: true
end
