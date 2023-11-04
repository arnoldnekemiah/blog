class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
  
    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = 'Failed to create the post.'
      render 'new'
    end
  end
  

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

  def new
    @user = User.find(params[:user_id]) # Fetch the user by their ID
    @post = @user.posts.build
  end

  private
  
  def post_params
    params.require(:post).permit(:text)
  end
  
end
