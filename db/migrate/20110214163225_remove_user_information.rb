class RemoveUserInformation < ActiveRecord::Migration
  def self.up
    remove_column :users, :crypted_password
    remove_column :users, :current_login_at
    remove_column :users, :current_login_ip
    remove_column :users, :login_count
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
    rename_column :users, :login, :email
  end

  def self.down
  end
end
