class UpdateTrainingsJob < ApplicationJob
  queue_as :default

	DAYS_OF_WEEK = { Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4, Saturday: 5, Sunday: 6 }

  def perform(session, city)
  	trainings = Training.session_is(session).upcoming
  	time = session.time_of_day
  	new_day = session.day.to_sym
  	trainings.each do |training|
  		day = update_training_day(training, new_day)
  		set_training_date(training, time, day)
  		training.save!
  	end
  end

  private

  def update_training_day(training, new_day)
  	training.date.next_week.advance(days: DAYS_OF_WEEK[new_day])
  end

  def set_training_date(training, time, day)
		training.date = day.to_datetime + time.seconds_since_midnight.seconds
  end

end

