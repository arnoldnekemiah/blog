require "application_system_test_case"
class UserIndexTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user, name: 'John', bio: 'Bio content')
    @user.posts.create(title: 'First Post', text: 'First post content')
  end
  test 'visiting the user index page' do
    visit users_path
    assert_text 'All Users'
    assert_selector '.user-row', count: 1
    assert_text @user.name
    click_on @user.name
    assert_current_path user_path(@user)
  end
end