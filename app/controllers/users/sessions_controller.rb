class Users::SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.zone.now + 2.hours.to_i
      render(json: { token:, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }, status: :ok)
    else
      render(json: { error: "unauthorized" }, status: :unauthorized)
    end
  end

  def destroy
    headers["Authorization"] = nil
    render(json: { message: "Logged out successfully" }, status: :ok)
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
