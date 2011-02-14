class User < ActiveRecord::Base
  
  has_many :holders
  has_many :accounts, :through => :holders
end
