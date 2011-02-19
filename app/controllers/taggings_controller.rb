class TaggingsController < ApplicationController
  before_filter :require_account
  respond_to :js

  def create
    params[:tagging][:user] = current_user
    @tagging = Tagging.create!(params[:tagging])
    Activity.action :create, @tagging, current_user
    respond_with @tagging
  end

  def destroy
    @tagging = Tagging.find params[:id]
    @tag = @account.tags.find @tagging.tag_id
    @tagging.destroy
    Activity.action :destroy, @tagging, current_user
    respond_with @tagging
  end

end