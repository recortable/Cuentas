class YearsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
    @years           = @account.years
    @months_by_years = @account.months_by_years
    respond_with @years
  end

  def show
    load_year
    respond_with @year
  end

  def update
    load_year
    @year.update_attributes(params[:year])
    redirect_to [@account, @year]
  end

  def calculate_months
    load_year
    @year.months.each do |month|
      month.calculate
      month.save
    end
    redirect_to [@account, @year]
  end

  private
  def load_year
    @year = @account.years.find_by_number(params[:id])
  end
end
