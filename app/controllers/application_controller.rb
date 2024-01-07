class ApplicationController < ActionController::API

  def jwt_authenticate
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ')[1]
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base)
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    rescue
      @user = nil
    end
  end
end
