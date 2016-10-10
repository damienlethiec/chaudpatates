class Training < ApplicationRecord
  belongs_to :city
  belongs_to :location
  has_many :bookings, dependent: :destroy

  validates :city_id, presence: true
  validates :date, presence: true
  validate :date_has_to_be_in_session

  has_attachment :photo

  def date_has_to_be_in_session
  	sessions_day = []
  	city.sessions.each { |session| sessions_day << session.day }
  	return if sessions_day.include?(date.strftime("%A")) && city.sessions.find_by(day: date.strftime("%A")).time_of_day.strftime("%H:%M") == date.strftime("%H:%M")
    errors.add(:date, I18n.t('activerecord.errors.messages.sessions'))
  end

  def to_s
    "#{self.date}, #{self.city.name}"
  end
end
