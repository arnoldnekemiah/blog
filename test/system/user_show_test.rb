require "application_system_test_case"
class UserShowTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user, name: 'John', bio: 'Bio content')
    @user.posts.create(title: 'First Post', text: 'First post content')
  end
  test 'visiting a user show page' do
    visit user_path(@user)
    assert_text 'Here is detail of a specific user'
    assert_text @user.name
    assert_text 'Bio content'
    assert_text 'First Post'
    click_on 'See all posts'
    assert_current_path user_posts_path(@user)
  end
end