require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'restaurants', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/restaurants' do

    get('list restaurants') do
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
          expect(data.count).to eq(6)
        end
      end
    end
  end

  path '/restaurants/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show restaurant') do
      response(200, 'successful') do
        let(:id) { Restaurant.last.id }

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
