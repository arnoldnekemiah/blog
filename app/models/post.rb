class Post < ApplicationRecord
  has_many :comments
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes
end
