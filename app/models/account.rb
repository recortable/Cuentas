class Account < ActiveRecord::Base
  validates_presence_of :number, :office_code, :entity_code, :control_code, :name, :owner
  has_many :holders
  has_many :movements, :order => 'DATE desc, id desc'
  has_many :months#, :order => 'YEAR desc, MONTH desc, ID desc'
  has_many :tags
  has_many :users, :through => :holders

  def complete_number
    "#{entity_code} #{office_code} #{control_code} #{number}"
  end

  def years
    (self.movements.last.d.year..Date.today.year).to_a
  end

  def account_number
    "#{entity_code}#{office_code}#{number}"
  end

  def movements_between(begin_date, end_date)
    Movement.where(:account_id => self.id, :date.gt => begin_date.to_db, :date.lte => end_date.to_db)
  end

  def to_param
    name ? "#{id}-#{name.parameterize}" : id.to_s
  end
end
