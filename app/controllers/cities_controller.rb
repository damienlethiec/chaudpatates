class CitiesController < ApplicationController
	skip_before_action :authenticate_user!, only: :show
	before_action :set_city, :set_next_training, :set_available_trainings, :set_city_members, only: [:show]

	def show
	end

	private

	def set_city
		@city = City.includes(:sessions).find(params[:id])
		authorize @city
	end

	def set_available_trainings
		@available_trainings = Training.not_booked_by(current_user, @city)
	end

	def set_next_training
		@next_training = Training.next_trainings_for(@city).first
	end

	def set_city_members
		@city_members = Training.find_city_members_for(@city)
	end
end
