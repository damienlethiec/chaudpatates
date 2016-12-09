class CitiesController < ApplicationController

	require "json"

	skip_before_action :authenticate_user!, only: :show

	def show
		set_city
		set_next_trainings
		set_next_training
    set_next_location
		set_city_members
		create_hash_location
	end

	private

	def set_city
		@city = City.includes(:sessions).find(params[:id])
		authorize @city
	end

	def set_next_trainings
		@next_trainings = @city.next_trainings(4)
	end

	def set_next_training
		@next_training = @city.next_trainings(4).first
	end

  def set_next_location
    @next_location = @next_training.location if @next_training && @next_training.location
  end

	def set_city_members
		@city_members = @city.find_city_members
	end

	def create_hash_location
    return unless @next_training && @next_training.location
		@hash_location = Gmaps4rails.build_markers(@next_training.location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow "<h5>#{location.name}</h5><p>#{location.address}</p>"
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
	end
end
