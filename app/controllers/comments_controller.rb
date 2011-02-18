class CommentsController < ApplicationController
  before_filter :require_account
  respond_to :js

  def create
    @movement = @account.movements.find params[:movement_id]
    comments = @movement.comments
    @movement.comments = comments.present? ? "#{comments}\n#{params[:body]}" : params[:body]
    @movement.save
    respond_with @movement
  end

end