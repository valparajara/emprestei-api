class AuthenticationController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # POST /sign_in
  def sign_in
    user = User.auth_user(user_params)

    respond_to do |format|
      format.json do
        if user.present?
          render json: user, root: :user
        else
          render json: { }, status: :unauthorized
        end
      end
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
