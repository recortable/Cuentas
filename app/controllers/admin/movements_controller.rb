class Admin::MovementsController < ApplicationController
    respond_to :html
  
  def index
    @movements = Movement.page params[:page]
    respond_with @movements
  end
end
