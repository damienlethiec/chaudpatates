class TrainingsController < ApplicationController
	before_action :set_training, only: :destroy
	skip_after_action :verify_policy_scoped, :only => :index

	def index
		@trainings = current_user.city.trainings.order(:date).includes(:location)
    authorize @trainings
	end

	def destroy
		if @training.destroy
      flash[:notice] = "Cet entrainement a bien été annulé"
      redirect_to(trainings_path)
    else
    	flash[:alert] = "Des utilisateurs se sont déjà inscrits à cet entrainement, vous ne pouvez plus l'annuler"
      (render :index)
    end
	end

	private

  def set_training
    @training = Training.find(params[:id])
    authorize @training
  end

  def before_destroy
  	throw :abort unless @training.bookings.empty?
  end
end
