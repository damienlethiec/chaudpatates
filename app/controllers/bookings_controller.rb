class BookingsController < ApplicationController

	before_action :set_booking, only: :destroy

	def index
		@bookings = policy_scope(Booking).includes( { training: [:location, :city] } )
		set_favorite_city
    authorize @bookings
  end

	def create
		@booking = Booking.new
		@booking.training = Training.find(params[:training])
		@booking.user = current_user
		@training = @booking.training
		authorize @booking
    # empecher de pouvoir réserver deux fois le même booking
    if current_user.bookings.include? @booking
      respond_to do |format|
        format.html {
          flash[:alert] = "Vous avez déjà booké cette séance!"
          redirect_to city_path(params[:city])
        }
        format.js
        end
      else
		    if current_user.tickets_nb > 0
          @booking.notify_customer if @booking.save
          @tickets_before_booking = current_user.tickets_nb
           current_user.tickets_nb -= 1
           current_user.save
           respond_to do |format|
            format.html {
              flash[:notice] = "Votre réservation a bien été prise en compte !!"
              redirect_to city_path(params[:city])
              }
              format.js
            end
        else
          @tickets_before_booking = 0
          respond_to do |format|
          format.html {
				  flash[:alert] = "Vous n'avez plus assez de tickets, merci d'en racheter !!"
				  redirect_to city_path(params[:city])
          }
				  format.js
			   end
		    end
    end
	end

	def destroy
		if (Time.current < @booking.training.date - 1.day) && @booking.destroy
			current_user.tickets_nb += 1
			current_user.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Votre inscription a bien été annulé"
          redirect_to(bookings_path)
        }
        format.js
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "Votre inscription à l'entrainement n'a pas été annulé"
          (render :index)
        }
        format.js
      end
    end
	end

	private

	def set_favorite_city
		@favorite_city = current_user.favorite_city
	end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

end
