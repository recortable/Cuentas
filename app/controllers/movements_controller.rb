class MovementsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
    @movements = @account.movements.order('DATE desc').page params[:page]
    respond_with @movements
  end
end
