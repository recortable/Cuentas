# To change this template, choose Tools | Templates
# and open the template in the editor.

class Tag < ActiveRecord::Base
  default_scope :order => 'NAME'
  belongs_to :account
  has_many :taggings, :dependent => :delete_all
  has_many :movements, :through => :taggings, :class_name => 'Movement', :order => 'date DESC'
  before_save :report!
  serialize :report

  validates_presence_of :name, :color

  def report!
    self.report = {}
    self.report[:movements_count] = self.movements.count
    positive = negative = 0
    self.movements.each do |movement|
      movement.ammount > 0 ? positive += movement.ammount : negative += movement.ammount
    end
    self.report[:positive] = positive
    self.report[:negative] = negative
    self.report[:balance] = negative + positive

  end
end

