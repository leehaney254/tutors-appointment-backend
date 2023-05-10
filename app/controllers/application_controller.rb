class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 'mysecret')
  end

  def decoded_token
    auth_header = request.headers['Authorization']
    return unless auth_header

    token = auth_header.split[1]
    begin
      JWT.decode(token, 'mysecret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token

    name = decoded_token[0]['name']
    @user = User.find_by(name: name)
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in_user
  end
end
