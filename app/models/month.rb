# Resúmenes mensuales
class Month < ActiveRecord::Base
  default_scope :order => 'year ASC, month ASC'
  belongs_to :account
  before_save :calculate

  def movements
    account.movements_between(begin_date, end_date)
  end

  def type
    balance < 0 ? 'negative' : 'positive'
  end

  def balance
    @balance ||= after_balance - before_balance
  end

  def begin_date
    @begin_date ||= Date.civil(year, month, 1)
  end

  def end_date
    @end_date ||= begin_date + 1.month - 1.day
  end

  def balance_before
    before_balance
  end

  def balance_after
    after_balance
  end

  def to_param
    "#{year}-#{month}"
  end

  def self.get(account_id, year, month)
    Month.find_or_create_by_account_id_and_year_and_month(account_id, year, month)
  end

  def calculate
    self.movements_count = self.movements.count
    self.positive_ammount = 0
    self.negative_ammount = 0
    all                   = self.movements.order('date asc')
    if self.movements_count > 0
      last                = all.last
      self.before_balance = all.first.balance_before
      self.after_balance  = last.balance_after
      all.each do |movement|
        if movement.ammount >= 0
          self.positive_ammount = self.positive_ammount + movement.ammount
        else
          self.negative_ammount = self.negative_ammount + movement.ammount
        end
      end
    else

    end
  end
end
