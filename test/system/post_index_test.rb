require 'application_system_test_case'

class PostIndexTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user, name: 'John')
    @post1 = @user.posts.create(title: 'First Post', text: 'First post content')
    @post2 = @user.posts.create(title: 'Second Post', text: 'Second post content')
  end

  test 'visiting a post index page' do
    visit user_posts_path(@user)

    assert_text 'Here is a list of posts for a given user'
    assert_selector '.post-link', count: 2
    assert_text @post1.title
    assert_text @post2.title

    click_on @post1.title
    assert_current_path user_post_path(@user, @post1)
  end
end
