# test/system/post_show_test.rb

require 'application_system_test_case'

class PostShowTest < ApplicationSystemTestCase
  setup do
    @user = User.create(name: 'John')
    @post = @user.posts.create(title: 'Test Post', text: 'This is a test post.')
    @comment = @post.comments.create(text: 'Test Comment', user: @user)
  end

  test 'viewing a post show page' do
    visit user_post_path(@user, @post)

    assert_selector 'h1', text: 'Here is the detail of a post for a specific user'
    assert_selector '.post-title', text: @post.title
    assert_selector '.post-content', text: @post.text
    assert_selector '.post-stats', text: "Comments: 1 | Likes: 0"

    assert_selector '.like-form'
    if has_css?('.unlike-link')
      assert_selector "input[type=submit][value='Unlike']"
    else
      assert_selector "input[type=submit][value='Like']"
    end

    assert_selector '.add-comments-container'
    assert_selector '.add-comment-div'
    assert_selector 'label', text: 'Text'
    assert_selector "textarea[name='comment[text]']"
    assert_selector "input[type='submit'][value='Add Comment']"

    assert_selector 'h2', text: 'Comments'
    
    # Check for comment items with specific content
    assert_selector '.comment', text: 'John : Test Comment'
  end
end
