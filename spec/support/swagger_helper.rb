# spec/support/swagger_helper.rb
RSpec.configure do |config|
    config.swagger_root = Rails.root.join('swagger').to_s
    config.swagger_docs = {
      'api/v1/swagger.json' => {
        openapi: '3.0.1',
        info: {
          title: 'Your API',
          version: 'v1',
        },
        paths: {},
      },
    }
  end
  