class AccountsController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    @accounts = current_user.accounts
    respond_with @account
  end

  def show
    @account = current_user.accounts.find params[:id]
    respond_with @account
  end

  def update
    @account = current_user.accounts.find params[:id]
    first    = @account.movements.first.d.year
    last     = Time.now.year
    first.upto(last) {|y| Year.find_or_create_by_account_id_and_number(@account.id, y) }
    redirect_to [@account, :months]
  end
end
