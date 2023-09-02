class Api::V1::ApiController < ActionController::API
  include ActionController::MimeResponds
  include RackSessionFix
  before_action :authenticate_user! 
  respond_to :json
end  