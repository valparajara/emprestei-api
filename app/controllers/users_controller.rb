class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def show
    respond_to do |format|
      format.json { render json: set_user }
    end
  end

  # POST /user.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:_id, :created_at, :crypted_password, :password_digest, :token_acesso, :updated_at, :email, :password, :password_confirmation)
    end
end
