class User < ActiveRecord::Base
  has_many :authorizations  
  has_many :holders
  has_many :accounts, :through => :holders, :readonly => false

  def admin?
    rol == 'admin'
  end
end
