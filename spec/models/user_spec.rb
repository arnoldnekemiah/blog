require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is not valid if posts_counter is negative' do
    user = User.new(name: 'Alice', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is not valid if posts_counter is not an integer' do
    user = User.new(name: 'Bob', posts_counter: 2.5)
    expect(user).to_not be_valid
  end

  it 'returns the 3 most recent posts' do
    user = create(:user) # Use FactoryBot to create a user with posts
    posts = user.most_recent_posts
    expect(posts.count).to eq(3)
  end
end
