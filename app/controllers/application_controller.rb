class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def token_authenticate

    unless params[:access_token].present?
      not_authenticated
      return
    end

    user = User.find_by(access_token: params[:access_token])

    if user.nil?
      not_authenticated
      return
    else
      @current_user = user
    end
  end

  def not_authenticated
    respond_to do |format|
      format.json { render json: {}, status: :unauthorized }
    end
  end
end
