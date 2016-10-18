class CreateTrainingsJob < ApplicationJob
  queue_as :default

  DAYS_OF_WEEK = { Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4, Saturday: 5, Sunday: 6 }

  def perform(session, city)
  	day = set_next_session_day(session)
  	time = session.time_of_day
  	until day > six_months_from_now
  		training = Training.new
  		training.city = city
  		training.session = session
  		set_training_date(training, time, day)
  		training.save!
  		day += 7.days
  	end
  end

  private

  def set_next_session_day(session)
  	Date.today.next_week.advance(days: DAYS_OF_WEEK[session.day.to_sym])
  end

  def six_months_from_now
  	Date.today + 6.months
  end

  def set_training_date(training, time, day)
		training.date = day.to_datetime + time.seconds_since_midnight.seconds
  end

end
