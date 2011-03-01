require 'openid/store/filesystem'

OmniAuth.configure do |config|
  config.full_host = 'http://cuentas.recortable.net'
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end
