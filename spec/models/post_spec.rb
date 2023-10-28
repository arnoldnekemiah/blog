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

  it 'is not valid if the title exceeds 250 characters' do
    long_title = 'A' * 251
    post = Post.new(title: long_title, author: user, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'returns the 5 most recent comments' do
    post = create(:post)
    comments = create_list(:comment, 6, post:)
    expect(comments.count).to eq(6)
  end
end
