class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.belongs_to :user
      t.belongs_to :account
      t.belongs_to :resource, :polymorphic => :true
      t.string :action, :limit => 16
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
