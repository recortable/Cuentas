class AddMovementsCountToSummaries < ActiveRecord::Migration
  def self.up
    add_column :years, :movements_count, :integer, :default => 0
    add_column :months, :movements_count, :integer, :default => 0
  end

  def self.down
    remove_column :years, :movements_count
    remove_column :months, :movements_count
  end
end
