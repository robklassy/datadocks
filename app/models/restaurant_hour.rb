class RestaurantHour < ApplicationRecord
  belongs_to :restaurant

  validates :day_of_week, inclusion: { in: %w(monday tuesday wednesday thursday friday saturday sunday),
    message: "%{value} is not a day of the week" }

  validates :open_at, presence: true
  validates :close_at, presence: true
end
