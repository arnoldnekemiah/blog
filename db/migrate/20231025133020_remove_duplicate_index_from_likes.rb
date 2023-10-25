class RemoveDuplicateIndexFromLikes < ActiveRecord::Migration[7.1]
  def change
    remove_index :likes, name: 'index_likes_on_user_id'
  end
end
