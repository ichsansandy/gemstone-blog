class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:like_counter)
  end
end
