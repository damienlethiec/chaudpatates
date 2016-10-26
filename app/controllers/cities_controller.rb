class CitiesController < ApplicationController
	skip_before_action :authenticate_user!, only: :show
	before_action :set_city, :set_next_training, :set_available_trainings, :set_city_members, :next_training_booked?, only: [:show]

	def show
	end

	private

	def set_city
		@city = City.includes(:sessions).find(params[:id])
		authorize @city
	end

	def next_training_booked?
		if current_user
			@next_training_booked = @next_training.booked_by?(current_user)
		end
	end

	def set_available_trainings
		if current_user
			@available_trainings = @city.trainings_not_booked_by(current_user)
		end
	end

	def set_next_training
		@next_training = @city.next_trainings.first
	end

	def set_city_members
		@city_members = @city.find_city_members
	end
end
