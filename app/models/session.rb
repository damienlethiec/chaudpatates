class Session < ApplicationRecord
  belongs_to :city
  has_many :trainings, dependent: :destroy

  enum day: [:Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday, :Sunday]

  validates :day, presence: true, inclusion: { in: days }
  validates :time_of_day, presence: true
  validates :city_id, presence: true

  after_commit :create_trainings, on: :create
	after_commit :update_trainings, on: :update

  private

  def create_trainings
    CreateTrainingsJob.set(wait: 10.seconds).perform_later(self, self.city)
  end

  def update_trainings
  	UpdateTrainingsJob.set(wait: 10.seconds).perform_later(self, self.city)
  end
end
