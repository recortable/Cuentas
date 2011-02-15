class AccountsController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    @accounts = current_user.accounts
    respond_with @account
  end

  def show
    redirect_to account_months_path(params[:id])
    #@account = current_user.accounts.find params[:id]
    #respond_with @account
  end

  def edit
    @account = current_user.accounts.find params[:id]
    respond_with @account    
  end

  def update
    @account = current_user.accounts.find params[:id]
    
    @account.update_attributes(params[:account])
    redirect_to [@account, :months]
  end
end
