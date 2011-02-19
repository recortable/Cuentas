class DashboardController < ApplicationController
  before_filter :require_user
  def show
    @year = Date.today.year
  end
end

