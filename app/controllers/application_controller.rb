class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, unless: :devise_controller?
  before_filter :set_tickets_package_for_order
  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  private

  def set_tickets_package_for_order
    @tickets_package = TicketsPackage.first
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo])
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  # def set_admin_timezone
  #   Time.zone = 'Paris'
  # end
end
