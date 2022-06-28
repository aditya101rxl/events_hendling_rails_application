class Tag < ApplicationRecord
	has_many :taggables, dependent: :destroy
	has_many :events, through: :taggables

	validates :name, uniqueness: true
end
