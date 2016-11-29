class TrainingsController < ApplicationController
	before_action :set_training, only: [:update, :destroy]
	skip_after_action :verify_policy_scoped, :only => :index

	def index
		if current_user.is_coach
			@trainings = current_user.city.trainings.upcoming.order(:date).includes(:location)
		else
			@trainings = Training.all
		end
    authorize @trainings
	end

  def new
    @training = Training.new
    authorize @training
  end

  def create
    @training = Training.new(training_params)
    @training.city = current_user.city
    authorize @training
    if @training.save
      flash[:notice] = "Ce nouvel entrainement a bien été créé"
      redirect_to(trainings_path)
    else
      flash[:alert] = "L'entraînement n'a pas pu être rajouté, merci de vérifier les erreurs ci-dessous"
      render :new
    end
  end

  def update
    if @training.update(training_params)
      flash[:notice] = "Cet entraînement a été mis à jour"
    else
      respond_to do |format|
        format.html { redirect_to(trainings_path) }
        format.js
      end
    end
  end

	def destroy
    if @training.destroy
      flash[:notice] = "Cet entrainement a bien été annulé"
    else
    	flash[:alert] = "Des utilisateurs se sont déjà inscrits à cet entrainement, vous ne pouvez plus l'annuler"
    end
    redirect_to(trainings_path)
	end

	private

  def training_params
    params.require(:training).permit(:date, :location_id, :public_description, :private_description)
  end

  def set_training
    @training = Training.find(params[:id])
    authorize @training
  end
end
