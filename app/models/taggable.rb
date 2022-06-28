class Taggable < ApplicationRecord
  belongs_to :event
  belongs_to :tag

  validate :unique_ralation

  def unique_ralation
    if Taggable.exists?(event_id: self.event_id, tag_id: self.tag_id)
      errors.add(:event_id, "Relation already exists")
    end
  end

end