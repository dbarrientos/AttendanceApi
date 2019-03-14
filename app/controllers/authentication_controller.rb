class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:admin_authenticate, :employee_authenticate]
  # return auth token once user is authenticated
  def admin_authenticate
    au = AuthenticateUser.new(auth_params[:email], auth_params[:password])
    if au.admin?
      auth_token = au.call
      json_response(auth_token: auth_token)
    else
      response = { message: Message.unauthorized}
      json_response(response, :unauthorized)
    end 
  end

  def employee_authenticate
    au = AuthenticateUser.new(auth_params[:email], auth_params[:password])
    auth_token = au.call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
