class Training < ApplicationRecord
  belongs_to :city
  belongs_to :location
  belongs_to :session
  has_many :bookings, dependent: :destroy

  validates :city_id, presence: true
  validates :date, presence: true
  validates :session, presence: true

  scope :session_is, -> (session) { where(session: session) }
  scope :past, -> { where("date < ?", Date.today) }
  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :city, -> (city) { where( city: city) }
  scope :training, -> (training) { where( training: training) }
  # validate :date_has_to_be_in_session

  has_attachment :photo

  def self.next_training_for(city)
    Training.upcoming.city(city).order(:date).first
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
