class AccountsController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    @accounts = current_user.accounts
    respond_with @account
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      @account.users << current_user
      @account.save
      flash[:notice] = "Nueva cuenta creada"
      Activity.create(:user_id => current_user.id, :action => 'create', :resource=> 'Session')
    end
    respond_with @account
  end

  def new
    @account = Account.new
    respond_with @account
  end

  def show
    redirect_to account_months_path(params[:id])
    #@account = current_user.accounts.find params[:id]
    #respond_with @account
  end

  def edit
    @account = current_user.accounts.find params[:id]
    respond_with @account
  end

  def update
    @account = current_user.accounts.find params[:id]
    @account.update_attributes(params[:account])
    redirect_to [@account, :months]
  end
end
