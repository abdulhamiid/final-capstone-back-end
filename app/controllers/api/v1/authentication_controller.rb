class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password? params[:password]
      token = JsonWebToken.encode(sub: user.id)
      render json: { token: }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
