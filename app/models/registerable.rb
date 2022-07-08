class Registerable < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :unique_ralation

  def unique_ralation
    if Registerable.exists?(event_id: self.event_id, user_id: self.user_id)
      errors.add(:event_id, "Relation already exists")
    end
  end
end
