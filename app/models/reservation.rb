class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :table
  belongs_to :restaurant

  def self.create_reservation_first_come(params)

    # within hours check
    return nil unless within_open_hours?(params)

    # check for any colliding reservations and exempt them from being chosen
    colliding_t_ids = colliding_table_ids(params)

    table = Table
      .where.not(id: colliding_t_ids)
      .where(restaurant_id: params[:restaurant_id])
      .where('number_of_seats >= ?', params[:number_of_guests]).first

    if table.present?
      res = Reservation.new(
        customer_id: params[:customer_id],
        table_id: table.id,
        restaurant_id: params[:restaurant_id],
        start_at: params[:start_at],
        end_at: params[:end_at],
        number_of_guests: params[:number_of_guests],
        date_of_reservation: params[:date_of_reservation],
        state: 'assigned'
      )
      res.save!
      return res
    end

    nil
  end

  def self.create_reservation_optimized(params)
    # within hours check
    return nil unless within_open_hours?(params)

    # check for any colliding reservations and exempt them from being chosen
    colliding_t_ids = colliding_table_ids(params)

    # chose only tables that are exact match for number of guests
    # choose only tables that have a server attached to them
    table = Table
      .joins(:server_tables)
      .where.not(id: colliding_t_ids)
      .where(restaurant_id: params[:restaurant_id])
      .where('number_of_seats = ?', params[:number_of_guests])
      .where('assigned_start_at >= ?', Date.parse(params[:date_of_reservation])).first

    if table.present?
      res = Reservation.new(
        customer_id: params[:customer_id],
        table_id: table.id,
        restaurant_id: params[:restaurant_id],
        start_at: params[:start_at],
        end_at: params[:end_at],
        number_of_guests: params[:number_of_guests],
        date_of_reservation: params[:date_of_reservation],
        state: 'assigned'
      )
      res.save!
      return res
    end

    nil
  end

  def self.colliding_table_ids(params)
    qry = Reservation
      .where(state: 'assigned')
      .where('DATE(date_of_reservation) = ?', Date.parse(params[:date_of_reservation]))
      .where('(? BETWEEN start_at AND end_at) OR (? BETWEEN start_at AND end_at) OR (? <= start_at AND ? >= end_at)', params[:start_at], params[:end_at], params[:start_at], params[:end_at])

    if params[:restaurant_id].present?
      qry = qry.where(restaurant_id: params[:restaurant_id])
    end

    qry.pluck(:table_id)
  end

  def self.within_open_hours?(params)
    # check if reservation is within operating hours
    requested_date = Date.parse(params[:date_of_reservation])
    dayname = Date::DAYNAMES[requested_date.wday].downcase
    rh = RestaurantHour.where(restaurant_id: params[:restaurant_id]).where(day_of_week: dayname).first

    if params[:start_at] < rh.open_at || params[:end_at] > rh.close_at
      return false
    end

    true
  end
end
