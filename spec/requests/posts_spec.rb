require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts/:id' do
    it 'returns http success' do
      @user = User.create(name: 'Ichsan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer')
      @post = Post.create(title: 'test', author_id: @user.id, text: 'this is testing')
      get user_post_path(user_id: @user.id, id: @post.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/:user_id/posts' do
    it 'returns http success' do
      @user = User.create(name: 'Ichsan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Web Developer')
      get user_posts_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
