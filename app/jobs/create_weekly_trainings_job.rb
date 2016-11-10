class CreateWeeklyTrainingsJob < ApplicationJob
  queue_as :default

  def perform
  	sessions = Session.all
  	sessions.each do |session|
			training = Training.new
			training.city = session.city
			training.session = session
			training.date = set_next_training(session)
			training.save!
  	end
  end

  private

  def set_next_training(session)
  	session.trainings.order(:date).last.date + 7.days
  end
end