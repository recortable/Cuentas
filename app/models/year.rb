class Year < ActiveRecord::Base
  before_save :report!
  serialize :report

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

  def r(key)
    report[key] if report
  end


  def report!
    1.upto(12).each do |month_number|
      month = Month.where(:account_id => self.account_id, :year => self.number, :month => month_number).first
      Month.create(:account_id => self.account_id, :year => self.number, :month => month_number) unless month
    end

    report = {:count => 0, :ammount => 0, :positive => 0, :negative => 0, :before => 0, :after => 0, :tags => {}}

    months = self.months

    report[:before] = months.first.r :before
    report[:after]= months.last.r :after
    if report[:after] == 0
      last = Movement.where(:account_id => self.account_id).order('date DESC').first
      report[:after] = last.balance
    end
    months.each do |month|
      report[:positive] += month.r :positive
      report[:negative] += month.r :negative
      report[:count] += month.r :count
      if month.report[:tags]
        month.report[:tags].each do |key, value|
        tag_report = report[:tags][key] ||= {:count => 0, :ammount => 0, :positive => 0, :negative => 0}
        tag_report[:color] = value[:color]
        tag_report[:count] += value[:count]
        tag_report[:ammount] += value[:ammount]
        tag_report[:positive] += value[:positive]
        tag_report[:negative] += value[:negative]
      end
      end
    end
    report[:ammount] = report[:after] - report[:before]
    self.report = report
  end
end
