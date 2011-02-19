class Admin::UsersController < ApplicationController
  before_filter :require_admin
  respond_to :html
  
  def index
    @users = User.order('updated_at DESC').page params[:page]
    respond_with @users
  end

  def edit
    @user = User.find params[:id]
    respond_with @user
  end

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.new(params[:user])
    Activity.action(:create, @user, current_user) if @user.save
    redirect_to admin_users_path
  end

  def update
    @user =User.find params[:id]
    Activity.action(:update, @user, current_user) if @user.update_attributes(params[:user])
    redirect_to admin_users_path
  end

end
