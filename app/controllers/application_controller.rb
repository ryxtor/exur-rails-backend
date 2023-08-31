class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit the first_name and last_name parameters along with other
    # sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender, :birth_date, :explorer, :admin])

    # Permit the first_name and last_name parameters along with other
    # account update parameters.
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :gender, :birth_date, :explorer, :admin])
  end
end
