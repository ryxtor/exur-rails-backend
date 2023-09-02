class ApplicationController < ActionController::API
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name gender birth_date explorer admin])

    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name gender birth_date explorer admin])
  end
end
