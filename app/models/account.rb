class Account < ActiveRecord::Base
  validates_presence_of :number, :office_code, :entity_code, :control_code, :name, :owner
  has_many :holders
  has_many :movements, :order => 'DATE'
  has_many :months#, :order => 'YEAR desc, MONTH desc, ID desc'
  has_many :years, :order => 'NUMBER desc'
  has_many :tags
  has_many :users, :through => :holders

  def complete_number
    "#{entity_code} #{office_code} #{control_code} #{number}"
  end

  def account_number
    "#{entity_code}#{office_code}#{number}"
  end

  def months_by_years
    self.months.group_by{|m| m.year}
  end

  def movements_between(begin_date, end_date)
    Movement.where(:account_id => self.id, :date.gt => begin_date.to_db, :date.lte => end_date.to_db).order('date')
  end

  def to_param
    name ? "#{id}-#{name.parameterize}" : id.to_s
  end
end
