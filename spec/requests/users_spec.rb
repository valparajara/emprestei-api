require "rails_helper"

describe UsersController  do

  describe "POST /users" do
    let(:user_serialized) { UserSerializer.new(User.last).to_json }

    context "when registration a user" do
      context "and without the required fields" do
        let(:user) { User.new }

        it "returns a 422 status" do
          post user_path, format: :json, user: user.as_json

          expect(status).to eq(422)
        end

        it "returns the user errors" do
          post user_path, format: :json, user: user.as_json
          user.save

          expect(response.body).to eq(user.errors.to_json)
        end
      end

      context "and registration with the required fields" do
        let(:user) { build (:user) }
        it "returns a 200 status" do
          post user_path, format: :json, user: { email: user.email, password: user.password }

          expect(status).to eq(200)
        end

        it "returns the user serialized" do
          post user_path, format: :json, user: user.as_json

          expect(response.body).to eq(user_serialized)
        end
      end
    end
  end
end
