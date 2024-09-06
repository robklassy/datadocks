require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'tables', type: :request do
  before(:all) do
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

  path '/tables/occupied' do

    get('occupied tables') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
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
