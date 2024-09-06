namespace :db do
  desc "seed db with some data"
  task seed: :environment do

    rest_names = [
      'City Wok',
      'Shi Tpa Town',
      'Cartman Burger',
      'Casa Bonita',
      'Country Kitchen Buffet',
      'Tweek Bros. Coffeehouse'
    ]

    customers = [
      'Randy Marsh',
      'Stan Marsh',
      'Eric Cartman',
      'Kenny McCormick',
      'Kyle Broflovski'
    ]

    servers = [
      'Tuong LuKim',
      'Matt Stone',
      'Trey Parker',
      'Barbra Streisand',
      'Richard Tweak',
      'Butters Stotch',
      'Craig Tucker',
      'Bebe Stevens',
      'Liane Cartman',
      'Tolkien Black',
      'Clyde Donovan'
    ]

    rest_names.each do |rn|
      Restaurant.find_or_create_by(name: rn) do |res|
        res.name = rn
      end
    end

    customers.each do |cus|
      names = cus.split(' ')
      Customer.find_or_create_by(first_name: names.first, last_name: names.last, type: 'Customer') do |c|
        c.first_name = names.first
        c.last_name = names.last
        c.type = 'Customer'
      end
    end

    servers.each do |ser|
      names = ser.split(' ')
      Server.find_or_create_by(first_name: names.first, last_name: names.last, type: 'Server') do |s|
        s.first_name = names.first
        s.last_name = names.last
        s.type = 'Server'
      end
    end

    # make 50 tables and distribute to restaurants
    res_ids = Restaurant.pluck(:id)
    50.times do |i|
      Table.find_or_create_by(identifier: i) do |t|
        t.identifier = i
        t.restaurant_id = res_ids.sample
        t.number_of_seats = rand(2..8)
        t.active = true
      end
    end

    # assign servers to tables
    s_ids = Server.pluck(:id)
    Table.all.each do |t|
      next if t.server_tables.count > 0
      st = ServerTable.new(
        server_id: s_ids.sample,
        assigned_start_at: Time.zone.now,
        table_id: t.id
      )
      st.save!
    end

    # hours of operations
    Restaurant.all.each do |rest|
      %w(monday tuesday wednesday thursday friday saturday sunday).each do |dow|
        RestaurantHour.find_or_create_by(restaurant_id: rest.id, day_of_week: dow) do |rh|
          rh.day_of_week = dow
          rh.open_at = (12 * 60)
          rh.close_at = (21 * 60)
          rh.max_time = [60, 90, 120].sample
        end
      end
    end

    # reservations
    Restaurant.all.each do |rest|
      next if rest.reservations.count > 0
      r = Reservation.new(
        customer_id: Customer.pluck(:id).sample,
        table_id: rest.tables.pluck(:id).sample,
        restaurant_id: rest.id,
        number_of_guests: 2,
        start_at: 13 * 60,
        end_at: 14 * 60,
        date_of_reservation: Time.zone.now,
        state: 'assigned'
      )
      r.save!
    end

  end
end