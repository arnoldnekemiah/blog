require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'updates likes counter for the associated post' do
    user = create(:user)
    post = create(:post, author: user)
    like = create(:like, post:)

    like.update_likes_counter
    post.reload

    expect(post.likes_counter).to eq(1)
  end
end
