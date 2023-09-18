class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def update_comments_counter
    update(comment_counter: comments.count)
  end

  def update_likes_counter
    update(like_counter: likes.count)
  end
end
