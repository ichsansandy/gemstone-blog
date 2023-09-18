class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_counter
    update(post_counter: posts.count)
  end

end
