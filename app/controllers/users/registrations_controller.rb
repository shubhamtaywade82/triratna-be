class Users::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.new(user_params)

    if user.save
      render(json: { status: "Successfully registered", data: { email: user.email, username: user.username } }, status: :created)
    else
      render(json: { status: "Couldn't register!", error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :mobile, :password, :password_confirmation)
  end
end
