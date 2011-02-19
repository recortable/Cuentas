class AddReportsToAccountsMonthsAndYears < ActiveRecord::Migration
  def self.up
    add_column :accounts, :report, :text
    add_column :accounts, :comments, :text
    add_column :months, :report, :text
    add_column :years, :report, :text
    change_column :months, :comments, :text
    change_column :years, :comments, :text
  end

  def self.down
    remove_column :accounts, :report
    remove_column :accounts, :comments
    remove_column :months, :report
    remove_column :years, :report
    change_column :months, :comments, :string
    change_column :years, :comments, :string
  end
end
