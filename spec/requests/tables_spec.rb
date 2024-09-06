require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'tables', type: :request do
  before(:all) do
    Reservation.delete_all
    Rake::Task["db:seed"].invoke
  end

  path '/restaurants/{restaurant_id}/tables' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    get('list tables') do
      response(200, 'successful') do
        let(:restaurant_id) do
          Restaurant.last.id
        end

        let(:table_ids) do
          Table.where(restaurant_id: restaurant_id).pluck(:id).sort
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
          ids = data.map { |d| d['id'] }.sort
          expect(ids).to eq(table_ids)
        end
      end
    end
  end

  path '/restaurants/{restaurant_id}/tables/{id}' do
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show table') do
      response(200, 'successful') do
        let(:restaurant_id) do
          Restaurant.first.id
        end

        let(:id) do
          Table.where(restaurant_id: restaurant_id).pluck(:id).sample
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
          expect(data['id']).to eq(id)
        end
      end
    end
  end

  path '/tables/occupied?date_of_reservation={date_of_reservation}&start_at={start_at}&end_at={end_at}' do
    parameter name: 'date_of_reservation', in: :path, type: :string, description: 'date_of_reservation'
    parameter name: 'start_at', in: :path, type: :string, description: 'start_at'
    parameter name: 'end_at', in: :path, type: :string, description: 'end_at'

    get('occupied tables') do
      response(200, 'successful') do

        example 'application/json', :discussion_question_post, [
            {"id"=>"f2780449-2af1-4611-848f-606e560b9de7",
            "identifier"=>"20",
            "number_of_seats"=>6,
            "active"=>true,
            "restaurant_id"=>"fabdd375-03ed-47bd-8b68-3d730a6298b0",
            "created_at"=>"2024-09-06T20:24:08.166Z",
            "updated_at"=>"2024-09-06T20:24:08.166Z"},
          {"id"=>"605fb246-46ed-4afc-98fb-323f7785d423",
            "identifier"=>"25",
            "number_of_seats"=>2,
            "active"=>true,
            "restaurant_id"=>"252d7e7f-b794-4b7a-9639-4f6ff1a3974d",
            "created_at"=>"2024-09-06T20:24:08.183Z",
            "updated_at"=>"2024-09-06T20:24:08.183Z"},
          {"id"=>"a7dcc970-b615-4f91-8f64-16d0f86a0691",
            "identifier"=>"31",
            "number_of_seats"=>8,
            "active"=>true,
            "restaurant_id"=>"53c89f01-92f9-46b0-8df8-128143fc5e10",
            "created_at"=>"2024-09-06T20:24:08.202Z",
            "updated_at"=>"2024-09-06T20:24:08.202Z"},
          {"id"=>"254c1896-9611-4c95-b8b9-b75ffb320387",
            "identifier"=>"34",
            "number_of_seats"=>6,
            "active"=>true,
            "restaurant_id"=>"c8eb4cd2-99a1-4b02-8230-9ff6038f0cff",
            "created_at"=>"2024-09-06T20:24:08.211Z",
            "updated_at"=>"2024-09-06T20:24:08.211Z"},
          {"id"=>"ee065406-d273-4af9-90f7-eaefca65c943",
            "identifier"=>"37",
            "number_of_seats"=>6,
            "active"=>true,
            "restaurant_id"=>"68e7d183-ec0d-4884-98b0-3a36a8ca4b19",
            "created_at"=>"2024-09-06T20:24:08.220Z",
            "updated_at"=>"2024-09-06T20:24:08.220Z"},
          {"id"=>"1da1c4ff-a9d8-47f0-a81e-1585d046e509",
            "identifier"=>"48",
            "number_of_seats"=>6,
            "active"=>true,
            "restaurant_id"=>"eaa183f0-3c3a-4028-8328-c6a01a4b530e",
            "created_at"=>"2024-09-06T20:24:08.261Z",
            "updated_at"=>"2024-09-06T20:24:08.261Z"}
        ]

        let(:date_of_reservation) { Time.zone.now }
        let(:start_at) { 12 * 60 }
        let(:end_at) { 20 * 60 }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          pp data
        end
      end
    end
  end

  path '/tables' do

    get('list tables') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.count).to eq(Table.count)
        end
      end
    end
  end

  path '/tables/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show table') do
      response(200, 'successful') do
        let(:id) { Table.last.id }

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
end
