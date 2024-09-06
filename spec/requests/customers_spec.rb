require 'swagger_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe 'customers', type: :request do
  before(:all) do
    Rake::Task["db:seed"].invoke
  end

  path '/customers' do

    get('list customers') do
      response(200, 'successful') do

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

  path '/customers/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show customer') do
      response(200, 'successful') do
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
