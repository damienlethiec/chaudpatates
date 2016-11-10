require 'test_helper'

class BookingMailerTest < ActionMailer::TestCase
  test "booked" do
    mail = BookingMailer.booked
    assert_equal "Booked", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "upcoming" do
    mail = BookingMailer.upcoming
    assert_equal "Upcoming", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
