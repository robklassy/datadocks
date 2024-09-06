class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :server_tables
  has_many :servers, through: :server_tables

  def self.occupied_tables(date_of_reservation, start_at, end_at)
    p = {
      start_at: start_at,
      end_at: end_at,
      date_of_reservation: date_of_reservation
    }
    t_ids = Reservation.colliding_table_ids(p)

    Table.where(id: t_ids)
  end
end
