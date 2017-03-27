class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :training

	validates :user_id, presence: true
	validates :training_id, presence: true

	scope :past, -> { joins(:training).merge(Training.past.order(:date)) }
	scope :upcoming, -> { joins(:training).merge(Training.upcoming.order(:date)) }
	scope :user_is, -> (user) { where(user: user) }
	scope :training, -> (training) { where( training: training) }


  before_destroy :notify_admin_cancellation, prepend: true

  def notify_customer
    BookingMailer.booked(self).deliver_now
    if (Time.current + 2.days > training.date)
      BookingMailer.delay_until(training.date - 2.days).upcoming(self)
    elsif Time.current + 1.days > training.date
      BookingMailer.delay_until(training.date - 1.day).upcoming(self)
    end
  end

  def notify_admin_cancellation
    BookingMailer.cancelled(self).deliver_now
  end

end
