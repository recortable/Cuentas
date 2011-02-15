class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthModule

  helper_method :current_user, :signed_in?

  def require_account
    if current_user
      @account = current_user.accounts.find params[:account_id]
    else
      store_location
      redirect_to login_path
    end
  end
end
