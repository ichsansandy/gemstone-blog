require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "should create valid like" do
    user = User.create(name: 'Henry')
    post = Post.create(author: user, title: 'Test')
    like = Like.create(post: post ,user: user)
    assert like.valid?
  end

  test "should not create like if no user" do
    user = User.create(name: 'Henry')
    post = Post.create(author: user, title: 'Test')
    like = Like.create(post: post)
    assert_not like.valid?
  end

  test "should not create like if no post" do
    user = User.create(name: 'Henry')
    like = Like.create(user: user)
    assert_not like.valid?
  end
end
