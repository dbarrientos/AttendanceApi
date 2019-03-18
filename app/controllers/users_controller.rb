class UsersController < ApplicationController
  authorize_resource
  # skip_before_action :authorize_request, only: :create
  
  # POST /signup
  # return authenticated token upon signup
  def index
    @users = []
    if current_user.admin?
      @users = User.all
      @users = @users.where("users.firstname like ?", "%#{params[:firstname]}%") if params[:firstname].present?
      @users = @users.where("users.lastname like ?", "%#{params[:lastname]}%") if params[:lastname].present?
      @users = @users.where("users.dni like ?", "%#{params[:dni]}%") if params[:dni].present?
      @users = @users.where(role: params[:rl]) if params[:rl].present?
    end
    json_response(@users.to_json(only: [:id, :firstname, :lastname, :email, :role, :dni, :address, :phone]))
  end

  def show
    user = User.find(params[:id])
    json_response(user.to_json(only: [:id, :firstname, :lastname, :email, :role, :dni, :address, :phone]))
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update  
    user = User.find(params[:id])
    if user.update(user_params)
      head :no_content
    else
      response = { message: Message.account_not_created, error: user.errors}
      json_response(response, :unprocessable_entity)
    end
  end

  def destroy
    user = User.find(params[:id])
    if user != current_user
      user.destroy
    end
    head :no_content
  end

  private

  def user_params
    params.permit(
      :firstname,
      :lastname,
      :address,
      :phone,
      :dni,
      :name,
      :email,
      :password,
      :password_confirmation,
      :role
    )
  end
end
