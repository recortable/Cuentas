class Admin::ActivitiesController < ApplicationController
  before_filter :require_admin
  respond_to :html

  def index
    @activities = Activity.page params[:page]
    respond_with @activities
  end

  def destroy
    @activity = Activity.find params[:id]
    @activity.destroy
    redirect_to :index
  end
end
