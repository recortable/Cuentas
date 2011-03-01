require 'openid/store/filesystem'

if Rails.env.production?
  OmniAuth.config.full_host = 'cuentas.recortable.net'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end
