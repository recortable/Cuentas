class Admin::UsersController < ApplicationController
  respond_to :html
  
  def index
    @users = User.page params[:page]
    respond_with @users
  end
end
