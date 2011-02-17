class TaggingsController < ApplicationController
  before_filter :require_account
  respond_to :js

  def destroy
    @tagging = Tagging.find params[:id]
    @tag = @account.tags.find @tagging.tag_id
    @tagging.destroy
    respond_with @tagging
  end

end