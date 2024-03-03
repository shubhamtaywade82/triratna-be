require "swagger_helper"

describe "Users::Registrations API" do
  path "/users/registration" do
    post "Creates a new user" do
      tags "Users::Registrations"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              first_name: { type: :string, example: "firstname" },
              last_name: { type: :string, example: "lastname" },
              username: { type: :string, example: "first_last" },
              email: { type: :string, format: :email, example: "first_last@example.com"},
              mobile: { type: :string, example: "8485956325" },
              password: { type: :string, example: "Password11$$" },
              password_confirmation: { type: :string, example: "Password11$$" }
            },
            required: %w[first_name last_name username email password password_confirmation]
          }
        },
        required: ["user"]
      }

      response "201", "user created" do
        let(:user) { { user: attributes_for(:user) } }
        run_test!
      end

      response "422", "invalid request" do
        let(:user) { { user: attributes_for(:user, username: "") } }
        run_test!
      end
    end
  end
end
