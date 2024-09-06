class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations

  validates :name, presence: true
end
