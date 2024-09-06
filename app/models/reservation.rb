class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :table
  belongs_to :restaurant

  def self.create_reservation_first_come(params)
  end

  def self.create_reservation_optimized(params)
  end
end
