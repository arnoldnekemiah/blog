# spec/requests/api/v1/posts_spec.rb
require 'swagger_helper'

describe 'API::V1::Posts', type: :request do
  path '/api/v1/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string, required: true

    get 'List posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      response '200', 'successful' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            title: { type: :string },
            text: { type: :string }
          }
        }

        run_test!
      end
    end
  end
end
