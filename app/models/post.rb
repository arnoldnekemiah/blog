class Post < ApplicationRecord
  belongs_to :user

  after_create do
    user.increment!(:posts_counter)
  end

  after_destroy do
    user.decrement!(:posts_counter)
  end
end
