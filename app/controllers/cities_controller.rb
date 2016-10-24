class CitiesController < ApplicationController
	skip_before_action :authenticate_user!, only: :show
	before_action :set_city, :set_next_training, :set_city_members, only: [:show]

	def show

	end

	private

	def set_city
		@city = City.includes(:sessions).find(params[:id])
		authorize @city
	end

	def set_next_training
		@next_training = Training.next_training_for(@city)
	end

	def set_city_members
		trainings = Training.past.city(@city).last(3)
		bookings = []
		trainings.each do |training| 
			training.bookings.each do |booking|
				bookings << booking
			end
		end
		@city_members = bookings.map { |booking| booking.user}.uniq[0..10]
	end
end
