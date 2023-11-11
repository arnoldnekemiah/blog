class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comments = @post.comments
    @new_comment = Comment.new(user: current_user, post: @post) # Initialize with the current post
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.build(post_params)
    @post.user_id = @user.id # Set the user_id explicitly
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to user_post_path(current_user, @post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(@user)
  end

  def like
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @like = current_user.likes.find_or_initialize_by(post: @post)
    if @like.save
      redirect_to user_post_path(@user, @post)
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to like the post.'
    end
  end

  def unlike
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @like = current_user.likes.find_by(post: @post)
    if @like&.destroy
      redirect_to user_post_path(@user, @post)
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to unlike the post.'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
