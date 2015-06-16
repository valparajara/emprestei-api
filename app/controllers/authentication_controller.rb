class AuthenticationController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :token_authenticate, except: :sign_in

  # POST /sign_in
  def sign_in
    user = User.auth_user(user_params)

    respond_to do |format|
      format.json do
        if user.present?
          user.generate_auth_tokens
          user.save
          render json: user, root: :user
        else
          render json: { }, status: :unauthorized
        end
      end
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password, :access_token)
  end
end
