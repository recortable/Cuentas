class Admin::UsersController < ApplicationController
  before_filter :require_admin
  respond_to :html
  
  def index
    @users = User.page params[:page]
    respond_with @users
  end
end
