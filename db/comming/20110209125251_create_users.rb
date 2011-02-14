class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :limit => 200
      t.string :email, :limit => 300
      t.string :rol, :limit => 16

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
