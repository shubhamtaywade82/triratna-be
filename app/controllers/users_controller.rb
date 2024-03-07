class UsersController < ApplicationController
  def show
    user_info = {
      name: "#{current_user.first_name} #{current_user.last_name}",
      email: current_user.email
    }
    render(json: { user_info: }, status: :ok)
  end
end
