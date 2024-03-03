require "rails_helper"

describe "Users::Registrations", type: :request do
  describe "POST /users/registration" do
    context "with valid parameters" do
      let(:user_attr) { attributes_for(:user) }
      let(:valid_params) do
        {
          user: user_attr
        }
      end

      it "creates a new user" do
        expect do
          post(users_registration_path, params: valid_params)
        end.to(change(User, :count).by(1))
      end

      it "returns a success response with email and username" do
        post users_registration_path, params: valid_params
        expect(response).to(have_http_status(:created))
        expect(response_body).to(eq({ status: "Successfully registered", data: { email: user_attr[:email], username: user_attr[:username] } }))
      end
    end

    context "with invalid parameters" do
      let(:user_attr) { attributes_for(:user, first_name: "") }
      let(:invalid_params) do
        {
          user: user_attr
        }
      end

      it "does not create a new user" do
        expect do
          post(users_registration_path, params: invalid_params)
        end.not_to(change(User, :count))
      end

      it "returns an unprocessable entity response with error message" do
        post users_registration_path, params: invalid_params
        expect(response).to(have_http_status(:unprocessable_entity))
        expect(response_body[:error]).to(include("First name can't be blank"))
      end
    end
  end

  # Helper method to parse response body as JSON
  def response_body
    JSON.parse(response.body, symbolize_names: true)
  end
end
