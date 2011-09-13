class MonthsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
#    @years           = @account.years
#    @months_by_years = @account.months_by_years
#    respond_with @years
    redirect_to [@account, :years]
  end

  def update
    load_month
    @month.update_attributes(params[:month])
    Activity.action(:update, @month, current_user) if @month.save
    redirect_to [@account, @month]
  end

  def show
    load_month
    respond_with @month
  end

  protected
  def load_month
    year = params[:id][0..3]
    month = params[:id][5..-1]
    @month = @account.months.
        where(:year => year).where(:month => month).first
    #@month = @account.months.find_by_year_and_month(year, month)
  end
end
