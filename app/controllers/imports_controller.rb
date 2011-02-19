class ImportsController < ApplicationController
  before_filter :require_account

  def new
  end

  def create
    @movements = []
    begin
      Movement.transaction do
        params[:movement].each do |param|
          movement         = Movement.new(param)
          movement.account = @account
          movement.save!
          @movements << movement
        end
        Activity.action :import, @account, current_user
      end
      #flash[:notice] = t('user_account_imports.create.success')
    rescue ActiveRecord::RecordInvalid => e
      @import = Import.new(@account, params[:import])
      #flash[:notice] = t('user_account_imports.create.fail')
      render :action => 'new'
      puts "EXCEPTION #{e}"
    end
  end

  def preview
    @import  = Importer.new(@account, params[:import])
    render :action => 'new'
  end
end
