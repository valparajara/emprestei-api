require "rails_helper"

describe AuthenticationController do
  let(:access_token) { SecureRandom.hex }
  let(:generated_access_tokens) { [access_token] }

  describe "POST /sign_in" do
    let(:user_serialized) { UserSerializer.new(User.last).to_json }

    context "when the user does not exists" do
      it "returns 401, with errors on username and password" do
        post sign_in_path(format: :json), user: { email: 'user@user.com', password: 'abcdef' }

        expect(response.status).to eq(401)
      end
    end

    context "when the user exists" do
      let(:user) {create :user}

      it "and invalid credentials are given" do
        post sign_in_path(format: :json), user: { email: user.email, password: "abcdef" }

        expect(response.status).to eq(401)
      end

      context "and valid credentials are given" do
        it "returns a success response with a generated access token" do
          post sign_in_path(format: :json), user: { email: user.email, password: user.password }

          expect(response.status).to eq(200)
          user.reload
          expect(response.body).to eq(user_serialized)
        end
      end
    end
  end
end
