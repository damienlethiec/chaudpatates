desc "This task create new trainings every week"
task :create_weekly_trainings => :environment do
	if Time.now.monday?
	  puts "Creating trainings..."
	  CreateWeeklyTrainingsJob.perform_now
	  puts "Trainings created"
	end
end