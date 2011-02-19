class Movement < ActiveRecord::Base
  validates_presence_of :account_id, :date, :ammount, :balance, :concept
  before_save :generate_code
  belongs_to :account
  attr_accessor :import

  has_many :taggings, :include => :tag
  has_many :tags, :through => :taggings

  def fecha
    d.fecha
  end

  def d
    @d ||= Date.from_db(self.date)
  end

  def import?
    import == 'import'
  end

  def type
    ammount < 0 ? 'negative' : 'positive'
  end

  def balance_before
    balance - ammount
  end

  def balance_after
    balance
  end


  def generate_code
    self.code = "#{self.date}#{self.ammount}#{self.balance}"
  end

  def comments?
    !self.comments.blank?
  end

  def name
    "#{date} | #{ammount} | #{concept}"
  end

end
