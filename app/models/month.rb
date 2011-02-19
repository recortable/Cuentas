# Resúmenes mensuales
class Month < ActiveRecord::Base
  default_scope :order => 'year ASC, month ASC'
  belongs_to :account
  before_save :report!
  serialize :report

  def movements
    account.movements_between(begin_date, end_date).order('date DESC')
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

  def r(key)
    report[key] if report
  end

  def report!
    all = self.movements
    report = {:positive => 0, :negative => 0, :count => 0, :ammount => 0,
              :before => 0, :after => 0, :tags => {}}
    report[:count] = all.size
    if report[:count] > 0
      last = all.last
      report[:before] = all.first.balance_before
      report[:after] = last.balance_after
      all.each do |movement|
        type = movement.ammount >= 0 ? :positive : :negative
        report[type] += movement.ammount
        movement.tags.each do |tag|
          tag_report = report[:tags][key] ||= {:count => 0, :ammount => 0, :positive => 0, :negative => 0}
          tag_report[:color] = tag.color
          tag_report[:count] += 1
          tag_report[:ammount] += movement.ammount
          tag_report[type] += movement.ammount
        end
      end
    elsif self.begin_date <= Date.today
      first_movement = account.movements.last
      if first_movement && first_movement.d > self.end_date
      else
        last_movement = account.movements.first
        if last_movement
          report[:before] = last_movement.balance
          report[:after] = last_movement.balance
        end
      end
    else
    end
    report[:ammount] = report[:after] - report[:before]
    self.report = report
  end
end
