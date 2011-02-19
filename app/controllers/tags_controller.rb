class TagsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
    @tags = @account.tags
    respond_with @tags
  end

  def new
    @tag = @account.tags.build
    respond_with @tag
  end

  def create
    @tag = @account.tags.build(params[:tag])
    if @tag.save
      flash[:notive] = "Etiqueta creada"
      Activity.action(:create, @tag, current_user)
    end
    redirect_to [@account, :tags]
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
    Activity.action(:update, @tag, current_user) if @tag.update_attributes(params[:tag])
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
