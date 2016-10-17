class Session < ApplicationRecord
  belongs_to :city

  enum day: [:Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday, :Sunday]

  validates :day, presence: true, inclusion: { in: days }
  validates :time_of_day, presence: true
  validates :city_id, presence: true

  after_save :async_update

  private

  def async_update
    CreateTrainingsJob.perform_later(self.id, self.city_id)
  end
end
