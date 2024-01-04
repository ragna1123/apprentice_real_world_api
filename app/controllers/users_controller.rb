class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: {user: user, token: jwt_cereate_token(user) }, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def jwt_cereate_token(payload)
    payload = {user_id: payload.id, exp: 24.hours.from_now.to_i}
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
