class BulkAction
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :name, :movement_ids, :tag_id, :url
  attr_reader :taggings

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def movement_ids=(ids)
    @movement_ids = ids.split(',')
  end

  def execute
    @taggings = []
    if name == 'apply_label' and movement_ids.present? and tag_id.present?
      movements.each do |movement|
        unless Tagging.find_by_movement_id_and_tag_id(movement.id, tag.id)
          @taggings << Tagging.create!(:movement_id => movement.id, :tag_id => tag.id)
        end
      end
    end
  end

  def movements
    @movements ||= Movement.find movement_ids
  end

  def tag
    @tag ||= Tag.find(tag_id) if tag_id.present?
  end

  def persisted?
    false
  end
end
