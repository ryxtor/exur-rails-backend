class ApplicationController < ActionController::API
  load_and_authorize_resource unless: :devise_controller?

  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name gender birth_date explorer admin username])

    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name gender birth_date explorer admin username])
  end
  rescue_from CanCan::AccessDenied do
    render json: { error: 'You are not authorized to access this page.' }, status: :unauthorized
  end
end
