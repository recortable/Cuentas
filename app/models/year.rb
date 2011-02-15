class Year < ActiveRecord::Base
  before_save :calculate
  
  def balance
    after_ammount - before_ammount
  end

  def balance_before
    before_ammount
  end

  def balance_after
    after_ammount
  end

  def months
    Month.where(:year => self.number, :account_id => self.account_id)
  end

  def to_param
    "#{number}"
  end

  private
  def calculate
    1.upto(12).each do |month_number|
      month = Month.where(:account_id => self.account_id, :year => self.number, :month => month_number).first
      Month.create(:account_id => self.account_id, :year => self.number, :month => month_number) unless month
    end


    positive = negative = total = 0
    months = self.months
    self.before_ammount = months.first.balance_before
    self.after_ammount = months.last.balance_after
    months.each do |month|
      positive += month.positive_ammount
      negative += month.negative_ammount
      total += month.movements_count
    end
    self.movements_count = total
    self.positive_ammount = positive
    self.negative_ammount = negative
  end
end
