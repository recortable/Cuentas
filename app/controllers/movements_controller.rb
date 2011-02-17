class MovementsController < ApplicationController
  before_filter :require_account
  respond_to :html

  def index
    if params[:q].present?
      query = @account.movements.where(:concept.matches => "%#{params[:q]}%")
    else
      query = @account.movements
    end
    @movements = query.order('DATE desc').page params[:page]
    respond_with @movements
  end
end
