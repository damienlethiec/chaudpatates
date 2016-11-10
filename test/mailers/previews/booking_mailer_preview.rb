# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booked
  def booked
  	booking = Booking.first
    BookingMailer.booked(booking)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/upcoming
  def upcoming
  	booking = Booking.first
    BookingMailer.upcoming(booking)
  end

end
