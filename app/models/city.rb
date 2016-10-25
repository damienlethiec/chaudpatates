class City < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :trainings, dependent: :destroy

  alias_attribute :coach, :user
  alias_attribute :coach=, :user=

  validates :name, presence: true
  validates :photo, presence: true
  validates :user_id, presence: true

  has_attachment :photo

  def next_trainings
    Training.includes(:location).upcoming.city(self).order(:date).first(6)
  end

  def find_city_members
    trainings = Training.includes(:bookings).city(self)
    bookings = []
    trainings.each do |training| 
      training.bookings.each do |booking|
        bookings << booking
      end
    end
    bookings.map { |booking| booking.user}.uniq[0..10]
  end

  def trainings_not_booked_by(user)
    trainings = self.next_trainings
    user.bookings.includes(:training).each do |booking|
      trainings.delete(booking.training) if trainings.include?(booking.training)
    end
    trainings
  end
end
