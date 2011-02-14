class MonthsController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    @account = current_user.accounts.find params[:account_id]
    @months  = @account.months
    respond_with @months
  end

  def show
    @account = current_user.accounts.find(params[:account_id])
    year     = params[:id][0..3]
    month    = params[:id][5..-1]
    @month   = @account.months.find_by_year_and_month(year, month)
    respond_with @month
  end
end
