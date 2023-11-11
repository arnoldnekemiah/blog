class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # Validation check
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :comments
  has_many :likes
  has_many :posts, foreign_key: 'author_id'

  def admin?
    role == 'admin' # Adjust based on how you determine if a user is an admin
  end

  def likes?(post)
    likes.exists?(post_id: post.id)
  end

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def recent_comments
    # criteria for recent comments, for example, comments within the last 7 days
    comments.where('created_at >= ?', 7.days.ago)
  end
end
