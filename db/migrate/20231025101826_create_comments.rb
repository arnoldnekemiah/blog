class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end

    unless index_exists?(:comments, :user_id)
      add_index :comments, :user_id
    end
  end
end
