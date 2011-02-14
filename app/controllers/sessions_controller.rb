class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_auth(auth)
      user = User.find_by_email(auth['user_info']['email'])
      user ? @auth = Authorization.create_from_auth(user, auth) : @message = "No estas registrado. Necesitas una invitacion para entrar."
    end

    if @auth
      self.current_user = @auth.user
      redirect_to root_path
    end
  end
end
