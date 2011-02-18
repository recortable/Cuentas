class AddReportToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :report, :text
    add_column :tags, :comments, :text
  end

  def self.down
    remove_column :tags, :report
    remove_column :tags, :text
  end
end


