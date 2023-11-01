require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET /index' do
    let(:valid_user_id) { 1 }

    before :each do
      get "/users/#{valid_user_id}/posts"
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns HTTP status 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the right view file' do
      expect(response).to render_template('posts/index')
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>Here is a list of posts for a given user</h1>')
    end
  end

  context 'GET /show' do
    let(:valid_user_id) { 1 }
    let(:valid_post_id) { 1 }

    before :each do
      get "/users/#{valid_user_id}/posts/#{valid_post_id}"
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns HTTP status 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the right view file' do
      expect(response).to render_template('posts/show')
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>Here is a list of posts for a given user</h1>')
    end
  end
end
