require 'application_system_test_case'

class PostShowTest < ApplicationSystemTestCase
  fixtures :users, :posts
  
  setup do
    @user = users(:john) # Reference the 'john' fixture from users.yml
    @post = posts(:first_post) # Reference the 'first_post' fixture from posts.yml
  end

  test 'viewing a post show page' do
    # Navigate to the post show page
    visit user_post_path(@user, @post)

    # Assertions based on the project requirements
    assert_text 'Here is the detail of a post for a specific user'
    assert_text @post.title
    assert_text "Posted by: #{@user.name}"
    assert_text "Comments: #{post.comments.count}"
    assert_text "Likes: #{post.likes.count}"
    assert_text @post.text

    # Check for comments
    assert_text 'Comments'
    @post.comments.each do |comment|
      assert_text "#{comment.user.name}:"
      assert_text comment.text
    end
  end

  test 'adding a new comment to a post' do
    @new_comment = Comment.new(text: 'This is a new comment')
    
    # Navigate to the post show page
    visit user_post_path(@user, @post)

    # Fill in and submit the new comment form
    within('.add-comments-container') do
      fill_in 'comment_text', with: @new_comment.text
      click_button 'Add Comment'
    end

    # Assertions after adding a new comment
    assert_text @new_comment.text
  end
end
