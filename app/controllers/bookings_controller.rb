class BookingsController < ApplicationController

	def create
		@booking = Booking.new
		@booking.training = Training.find(params[:training])
		@booking.user = current_user
		authorize @booking
		if current_user.tickets_nb > 0
			@booking.save
			current_user.tickets_nb -= 1
			current_user.save
			flash[:notice] = "Votre réservation a bien été prise en compte !!"
			redirect_to city_path(params[:city])
		else
			flash[:alert] = "Vous n'avez plus assez de tickets, merci d'en racheter !!"
			redirect_to city_path(params[:city])
		end
	end
	
end
