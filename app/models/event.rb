class Event < ApplicationRecord
	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables

	has_many :registerables
	has_many :users, through: :registerables

	validates :title, presence: true
	validates :description, presence: true, length: { minimum: 11}
	validates :registration_start, presence: true
	validates :registration_end, presence: true
	validates :venue, presence: true
	validates :event_type, presence: true
end
