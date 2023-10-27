class User < ApplicationRecord
  # Validation check
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  # Associations
  has_many :comments
  has_many :likes
  has_many :posts, foreign_key: 'author_id'

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
