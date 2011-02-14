class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :resource, :polymorphic => true

  default_scope :order => 'id DESC'
end
