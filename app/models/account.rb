class Account < ActiveRecord::Base
  before_save :report!
  validates_presence_of :number, :office_code, :entity_code, :control_code, :name, :owner
  has_many :holders
  has_many :movements
  has_many :months #, :order => 'YEAR desc, MONTH desc, ID desc'
  has_many :years, :order => 'NUMBER desc'
  has_many :tags
  has_many :users, :through => :holders
  serialize :report

  def complete_number
    "#{entity_code} #{office_code} #{control_code} #{number}"
  end

  def account_number
    "#{entity_code}#{office_code}#{number}"
  end

  def months_by_years
    self.months.group_by { |m| m.year }
  end

  def movements_between(begin_date, end_date)
    Movement.where(:account_id => self.id, :date.gte => begin_date.to_db, :date.lte => end_date.to_db).order('date ASC, id DESC')
  end

  def to_param
    name ? "#{id}-#{name.parameterize}" : id.to_s
  end

  def report!
    last_year = Date.today.year
    last_movement = self.movements.last
    first_year = last_movement ? last_movement.d.year : last_year
    first_year.upto(last_year) do |year|
      self.years.find_or_create_by_number(year)
    end


    report = {:count => 0, :ammount => 0, :positive => 0, :negative => 0, :before => 0, :after => 0, :tags => {}}

    years = self.years
    if years.size > 0
      report[:before] = years.last.r :before
      report[:after] = years.first.r :after
      years.each do |year|
        report[:count] = year.r :count
        report[:ammount] += year.r :ammount
        report[:positive] += year.r :positive
        report[:negative] += year.r :negative
        if year.report[:tags]
          year.report[:tags].each do |key, value|
            tag_report = report[:tags][key] ||= {:count => 0, :ammount => 0, :positive => 0, :negative => 0}
            tag_report[:color] = value[:color]
            tag_report[:count] += value[:count]
            tag_report[:ammount] += value[:ammount]
            tag_report[:positive] += value[:positive]
            tag_report[:negative] += value[:negative]
          end
        end
      end
    end
    self.report = report
  end
end
