require "rails_helper"

describe AuthenticationController do
  describe "POST /sign_in" do

    context "when the user does not exists" do
      it "returns 401, with errors on username and password" do
        post sign_in_path(format: :json), user: { email: 'user@user.com', password: 'abcdef' }

        expect(response.status).to eq(401)
      end
    end

    context "when the user exists" do
      let(:user) {create :user}
      it "and valid credentials are given" do
        post sign_in_path(format: :json), user: { email: user.email, password: user.password }

        expect(response.status).to eq(200)
      end
    end
  end
end
