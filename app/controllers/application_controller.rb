class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
	  registration_params = [:first_name, :last_name, :email, :password, :password_confirmation, :city, :country, :gender, :birthday]

	  if params[:action] == 'update'
		  devise_parameter_sanitizer.for(:account_update) {
				  |u| u.permit(registration_params )
		  }
	  end
  end


	def index
		render :text => "<pre>" + current_user.to_yaml and return
	end
end
