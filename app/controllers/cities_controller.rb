class CitiesController < ApplicationController

	require "json"

	skip_before_action :authenticate_user!, only: :show

	def show
		set_city
		set_next_trainings
		set_next_training
		set_available_trainings
		set_city_members
		next_training_booked?
		create_hash_location
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

	def set_next_trainings
		@next_trainings = @city.next_trainings
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

	def create_hash_location
		@hash_location = Gmaps4rails.build_markers(@next_training.location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow "<h5>#{location.name}</h5><p>#{location.address}</p>"
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
	end
end
