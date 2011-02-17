class TagReport
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :tag, :movements_count

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end