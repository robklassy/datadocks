class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations
  has_many :restaurant_hours

  validates :name, presence: true
end
