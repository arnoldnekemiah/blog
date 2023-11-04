class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id]) # Fetch the user by their ID
    @posts = @user.posts # Fetch the posts related to the user
    @recent_comments = @user.recent_comments # Fetch the recent comments for the user
    @comments = @recent_comments
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end
