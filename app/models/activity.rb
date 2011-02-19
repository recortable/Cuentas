class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :resource, :polymorphic => true

  default_scope :order => 'id DESC'

  def resource_name
    self.resource.name if self.resource_id
  end

  def path
    if self.resource_id
      if self.resource_type == 'Account'
        @path ||= [self.resource]
      else
        resource = self.resource
        @path ||= [resource.account, resource]
      end
    end
    @path ||= nil
  end

  def self.action(action, resource, current_user)
    Activity.create(:user_id => current_user.id, :action => action.to_sym, :resource => resource)
  end
end
