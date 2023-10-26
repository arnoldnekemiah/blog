class User < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts, foreign_key: 'author_id'

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
