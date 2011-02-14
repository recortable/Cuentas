class Admin::AccountsController < ApplicationController
  respond_to :html
  
  def index
    @accounts = Account.all
    respond_with @accounts
  end
end
