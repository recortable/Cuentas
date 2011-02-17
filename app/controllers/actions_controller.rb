class ActionsController < ApplicationController
  before_filter :require_account
  respond_to :html, :js

  def create
    @action = BulkAction.new(params[:bulk_action])
    @action.execute
    respond_with @action
  end
end