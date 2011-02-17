class TagsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
    @tags = @account.tags
    respond_with @tags
  end

  def show
    @tag = @account.tags.find params[:id]
    respond_with @tag
  end
end
