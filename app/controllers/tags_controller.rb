class TagsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
    @tags = @account.tags
    respond_with @tags
  end

  def show
    load_tag
    respond_with @tag
  end

  def edit
    load_tag
    respond_with @tag
  end

  def update
    load_tag
    @tag.update_attributes(params[:tag])
    redirect_to [@account, @tag]
  end

  def load_tag
    @tag = @account.tags.find params[:id]
  end

  def calculate
    @account.tags.all.each {|t| t.save }
    redirect_to [@account, :tags]
  end

end
