class MonthSummariesToMonths < ActiveRecord::Migration
  def self.up
    rename_table :month_summaries, :months
  end

  def self.down
    rename_table :months, :month_summaries
  end
end
