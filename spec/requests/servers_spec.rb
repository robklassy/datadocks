require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'servers', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/servers' do

    get('list servers') do
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
          expect(data.count).to eq(11)
        end
      end
    end
  end

  path '/servers/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show server') do
      response(200, 'successful') do
        let(:id) { Server.first.id }

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
