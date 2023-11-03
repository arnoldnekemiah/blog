class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id]) # Fetch the user by their ID
    @posts = @user.posts # Fetch the posts related to the user
    @comments = Comment.where(post_id: @posts.pluck(:id)) # Fetch comments related to these posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end
