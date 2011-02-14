class AccountsController < ApplicationController
  before_filter :require_user
  respond_to :html
  
  def index
    @accounts = current_user.accounts
    respond_with @account
  end

  def show
    redirect_to account_months_path(params[:id])
    return
    @account = current_user.accounts.find params[:id]
    respond_with @account
  end
end
