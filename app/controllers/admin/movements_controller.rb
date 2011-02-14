class Admin::MovementsController < ApplicationController
    respond_to :html
  
  def index
    @movements = Movement.limit(50)
    respond_with @movements
  end
end
