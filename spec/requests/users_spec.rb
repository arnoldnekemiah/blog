require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a 200 status code' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET /show' do
    it 'returns a 200 status code' do
      # Assuming you have a user with ID 1, you can change this as needed
      get user_path(1)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      # Assuming you have a user with ID 1, you can change this as needed
      get user_path(1)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      # Assuming you have a user with ID 1, you can change this as needed
      get user_path(1)
      expect(response.body).to include('Here is a selected user')
    end
  end
end
