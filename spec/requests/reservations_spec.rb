require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'reservations', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/reservations' do
    get('list reservations') do
      response(200, 'successful') do

        example 'application/json', :reservation, [
          {
            "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
            "customer_id"=>"f835547b-a0eb-462e-823e-f7688cdecfce",
            "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
            "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
            "start_at"=>1080,
            "end_at"=>1140,
            "number_of_guests"=>2,
            "state"=>"assigned",
            "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
            "created_at"=>"2024-09-06T23:14:01.667Z",
            "updated_at"=>"2024-09-06T23:14:01.667Z"
          },

          {
            "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
            "customer_id"=>"f835547b-a0ab-462e-823e-f7688cdecf12",
            "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
            "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
            "start_at"=>980,
            "end_at"=>1040,
            "number_of_guests"=>4,
            "state"=>"assigned",
            "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
            "created_at"=>"2024-09-06T23:14:01.667Z",
            "updated_at"=>"2024-09-06T23:14:01.667Z"
          }
        ]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.count).to eq(Reservation.count)
        end
      end
    end

    post('create reservation') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          customer_id: { type: :string },
          restaurant_id: { type: :string },
          start_at: { type: :string },
          end_at: { type: :string },
          number_of_guests: { type: :string },
          date_of_reservation: { type: :string },
          optimized: { type: :string }
        }
      }

      response(200, 'successful') do
        example 'application/json', :reservation, {
          "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
          "customer_id"=>"f835547b-a0eb-462e-823e-f7688cdecfce",
          "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
          "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
          "start_at"=>1080,
          "end_at"=>1140,
          "number_of_guests"=>2,
          "state"=>"assigned",
          "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
          "created_at"=>"2024-09-06T23:14:01.667Z",
          "updated_at"=>"2024-09-06T23:14:01.667Z"
        }

        let(:reservation) do
          c = Customer.all.sample
          r = Restaurant.all.sample
          {
            customer_id: c.id,
            restaurant_id: r.id,
            date_of_reservation: Time.zone.now + 1.days,
            number_of_guests: 2,
            start_at: 18 * 60,
            end_at: 19 * 60,
            optimized: false
          }
        end

        let(:optimized) do
          { optimized: 'false' }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['table_id']).not_to eq(nil)
        end
      end
    end

    post('create reservation optimized') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          customer_id: { type: :string },
          restaurant_id: { type: :string },
          start_at: { type: :string },
          end_at: { type: :string },
          number_of_guests: { type: :string },
          date_of_reservation: {type: :string },
          optimized: { type: :string }
        }
      }

      response(200, 'successful') do
        example 'application/json', :reservation, {
          "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
          "customer_id"=>"f835547b-a0eb-462e-823e-f7688cdecfce",
          "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
          "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
          "start_at"=>1080,
          "end_at"=>1140,
          "number_of_guests"=>2,
          "state"=>"assigned",
          "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
          "created_at"=>"2024-09-06T23:14:01.667Z",
          "updated_at"=>"2024-09-06T23:14:01.667Z"
        }

        let(:reservation) do
          c = Customer.all.sample
          r = Restaurant.all.first
          seats = r.tables.pluck(:number_of_seats).sample
          ids = ServerTable.where(table_id: r.tables.pluck(:id))

          {
            customer_id: c.id,
            restaurant_id: r.id,
            date_of_reservation: Time.zone.now,
            number_of_guests: seats,
            start_at: 13 * 60,
            end_at: 14 * 60,
            optimized: 'true'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['table_id']).to eq(nil)
        end
      end
    end
  end

  path '/reservations/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show reservation') do
      response(200, 'successful') do
        example 'application/json', :reservation, {
        "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
        "customer_id"=>"f835547b-a0eb-462e-823e-f7688cdecfce",
        "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
        "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
        "start_at"=>1080,
        "end_at"=>1140,
        "number_of_guests"=>2,
        "state"=>"assigned",
        "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
        "created_at"=>"2024-09-06T23:14:01.667Z",
        "updated_at"=>"2024-09-06T23:14:01.667Z"
      }

        let(:id) { Reservation.last.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
        end
      end
    end
  end

  path '/restaurants/{restaurant_id}/reservations' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    get('list reservations') do
      response(200, 'successful') do

        example 'application/json', :reservation, [
          {
            "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
            "customer_id"=>"f835547b-a0eb-462e-823e-f7688cdecfce",
            "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
            "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
            "start_at"=>1080,
            "end_at"=>1140,
            "number_of_guests"=>2,
            "state"=>"assigned",
            "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
            "created_at"=>"2024-09-06T23:14:01.667Z",
            "updated_at"=>"2024-09-06T23:14:01.667Z"
          },

          {
            "id"=>"32a0b18a-98a2-4610-a284-c6a79d35f7d4",
            "customer_id"=>"f835547b-a0ab-462e-823e-f7688cdecf12",
            "table_id"=>"1e78b073-608f-4662-813d-430b807998a3",
            "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
            "start_at"=>980,
            "end_at"=>1040,
            "number_of_guests"=>4,
            "state"=>"assigned",
            "date_of_reservation"=>"2024-09-07T23:14:01.654Z",
            "created_at"=>"2024-09-06T23:14:01.667Z",
            "updated_at"=>"2024-09-06T23:14:01.667Z"
          }
        ]
        let(:restaurant_id) { Restaurant.last.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.count).to eq(1)
        end
      end
    end
  end

  path '/restaurants/{restaurant_id}/reservations/{id}' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show reservation') do
      response(200, 'successful') do
        let(:restaurant_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
