class SessionsController < ApplicationController

  def new
    response.headers['Cache-Control'] = 'public, max-age=30000' if Rails.env.production?
  end

  def create
    auth = request.env['omniauth.auth']
    @email = auth['user_info']['email']
    unless @auth = Authorization.find_from_auth(auth)
      user = User.find_by_email(@email)
      user ? @auth = Authorization.create_from_auth(user, auth) : @message = "No estas registrado. Necesitas una invitacion para entrar."
    end

    if @auth
      self.current_user = @auth.user
      self.current_user.update_attributes(:last_login_at => Time.now, :login_count => self.current_user.login_count + 1)
      Activity.create(:user_id => current_user.id, :action => 'create', :resource_type => 'Session')
      redirect_to root_path
    end
  end

  def destroy
    self.clear_user
    redirect_to root_path
  end

  unless Rails.env.production?
    def enter
      self.current_user = User.find params[:id]
      redirect_to root_path
    end
  end
end
