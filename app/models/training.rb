class Training < ApplicationRecord
  belongs_to :city
  belongs_to :location
  belongs_to :session
  has_many :bookings, dependent: :destroy

  validates :city_id, :date, presence: true
  validates :location, :public_description, :private_description, presence: true, on: :update
  validates :public_description, :private_description, length: { minimum: 140 }, on: :update
  validate :date_cannot_be_in_the_past, on: :create
  # validate :date_has_to_be_in_session

  scope :session_is, -> (session) { where(session: session) }
  scope :past, -> { where("date < ?", Date.today) }
  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :city, -> (city) { where( city: city) }

  has_attachment :photo

  def booked_by?(user)
    user.bookings.each do |booking|
      return true if booking.training == self
    end
    return false
  end

  def number_of_participants
    self.bookings.count
  end

  def date_cannot_be_in_the_past
    return if date > Date.today
    errors.add(:date, 'Merci de sélectionner une date dans le futur')
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
