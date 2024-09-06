class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :server_tables
  has_many :servers, through: :server_tables
end
