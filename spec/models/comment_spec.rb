require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'updates comments counter for the associated post' do
    user = create(:user)
    post = create(:post, author: user)
    comment = create(:comment, post:)

    comment.update_comments_counter
    post.reload

    expect(post.comments_counter).to eq(1)
  end
end
