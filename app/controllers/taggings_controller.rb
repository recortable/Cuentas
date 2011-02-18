class TaggingsController < ApplicationController
  before_filter :require_account
  respond_to :js

  def create
    params[:tagging][:user] = current_user
    @tagging = Tagging.create!(params[:tagging])
    respond_with @tagging
  end

  def destroy
    @tagging = Tagging.find params[:id]
    @tag = @account.tags.find @tagging.tag_id
    @tagging.destroy
    respond_with @tagging
  end

end