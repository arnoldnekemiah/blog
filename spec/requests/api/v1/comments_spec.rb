require 'swagger_helper'

describe 'API::V1::Comments', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, required: true
    parameter name: 'post_id', in: :path, type: :string, required: true

    get 'List comments for a user\'s post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string

      response '200', 'successful' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            text: { type: :string }
          }
        }

        run_test!
      end
    end

    post 'Create a comment for a user\'s post' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'comment created' do
        schema type: :object, properties: {
          id: { type: :integer },
          text: { type: :string }
        }

        run_test!
      end

      response '422', 'unprocessable entity' do
        schema type: :object, properties: {
          errors: { type: :array, items: { type: :string } }
        }

        run_test!
      end
    end
  end
end
