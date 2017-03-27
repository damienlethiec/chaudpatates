class BookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booked.subject
  #
  def booked(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Votre réservation a bien été enregistrée")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.upcoming.subject
  #
  def upcoming(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Votre entrainement approche !!")
  end

  def cancelled(booking)
    @booking = booking
    mail(to: 'juliette.engel@skema.edu', subject: "#{@booking.user.full_name} a annulé sa séance")
  end
end
