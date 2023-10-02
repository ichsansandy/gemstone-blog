require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/:id' do
    it 'returns http success' do
      @user = User.create(name: 'Ichsan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer')
      get user_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
