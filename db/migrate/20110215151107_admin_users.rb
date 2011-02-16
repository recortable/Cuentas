class AdminUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :last_login_at
    remove_column :users, :last_login_ip
    add_column :users, :rol, :string, :limit => 8
  end

  def self.down
    add_column :users, :last_login_at, :datetime
    add_column :users, :last_login_ip, :string
    remove_column :users, :rol
  end
end
