module ExceptionHandler

  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from CanCan::AccessDenied, with: :unauthorized_request  
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    
    rescue_from ActionController::UnknownController, with: :record_not_found
    rescue_from ActionController::RoutingError, with: :record_not_found
    rescue_from AbstractController::ActionNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def record_not_found(e)
    json_response({ message: e.message }, :not_found)
  end
  
end