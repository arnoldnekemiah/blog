class Post < ApplicationRecord
  # Validations check
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def liked_by?(user)
    likes.exists?(user:)
  end

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
