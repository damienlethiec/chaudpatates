class Training < ApplicationRecord
  belongs_to :city
  belongs_to :location
  belongs_to :session
  has_many :bookings, dependent: :destroy

  validates :city_id, presence: true
  validates :date, presence: true
  validates :session, presence: true
  # validate :date_has_to_be_in_session

  scope :session_is, -> (session) { where(session: session) }
  scope :past, -> { where("date < ?", Date.today) }
  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :city, -> (city) { where( city: city) }
  scope :training, -> (training) { where( training: training) }

  has_attachment :photo

  def self.next_trainings_for(city)
    Training.includes(:location).upcoming.city(city).order(:date).first(6)
  end

  def self.find_city_members_for(city)
    trainings = Training.past.includes(:bookings).city(city)
    bookings = []
    trainings.each do |training| 
      training.bookings.each do |booking|
        bookings << booking
      end
    end
    bookings.map { |booking| booking.user}.uniq[0..10]
  end

  def self.not_booked_by(user, city)
    trainings = Training.next_trainings_for(city)
    user.bookings.includes(:training).each do |booking|
      trainings.delete(booking.training) if trainings.include?(booking.training)
    end
    trainings
  end

  # def date_has_to_be_in_session
  # 	sessions_day = []
  # 	city.sessions.each { |session| sessions_day << session.day }
  # 	return if sessions_day.include?(date.strftime("%A")) && city.sessions.find_by(day: date.strftime("%A")).time_of_day.strftime("%H:%M") == date.strftime("%H:%M")
  #   errors.add(:date, I18n.t('activerecord.errors.messages.sessions'))
  # end

  def to_s
    "#{self.date}, #{self.city.name}"
  end
end
