class CreateYears < ActiveRecord::Migration
  def self.up
    create_table :years do |t|
      t.belongs_to :account
      t.integer :number
      t.integer :positive_ammount, :default => 0
      t.integer :negative_ammount, :default => 0
      t.integer :before_ammount, :default => 0
      t.integer :after_ammount, :default => 0
      t.string :tag_summary, :length => 4096
      t.string :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :years
  end
end
