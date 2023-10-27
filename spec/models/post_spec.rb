require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    post = Post.new(title: 'A Title', author: user, comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = Post.new(author: user, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is not valid if comments_counter is negative' do
    post = Post.new(title: 'A Title', author: user, comments_counter: -1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is not valid if likes_counter is not an integer' do
    post = Post.new(title: 'A Title', author: user, comments_counter: 0, likes_counter: 2.5)
    expect(post).to_not be_valid
  end

  it 'returns the 5 most recent comments' do
    post = create(:post) # Use FactoryBot to create a post with comments
    comments = post.most_recent_comments
    expect(comments.count).to eq(5)
  end
end
