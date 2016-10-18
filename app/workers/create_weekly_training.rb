# class CreateWeeklyTraining
#   include Sidekiq::Worker

#   def perform
#   	sessions = Session.all
#   	sessions.each do |session|
# 			training = Training.new
# 			training.city = session.city
# 			training.session = session
# 			training.date = set_next_training(session)
# 			training.save!
#   	end
#   end

#   private

#   def set_next_training(session)
#   	session.trainings.last.date + 7.days
#   end
# end