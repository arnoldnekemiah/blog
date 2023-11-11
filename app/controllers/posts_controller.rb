class PostsController < ApplicationController
  load_and_authorize_resource except: %i[like unlike]
  before_action :set_user
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comments = @post.comments
    @show ||= Comment.new(user: current_user, post: @post) # Initialize with the current post
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
    @post = Post.find(params[:id])
    @like = current_user.likes.find_or_initialize_by(post: @post)

    authorize! :create, Like # Authorize creation of Like objects

    if @like.save
      @like.update_likes_counter
      flash[:notice] = 'Liked the post!'
    else
      flash[:error] = 'Failed to like the post.'
    end

    redirect_to user_post_path(@user, @post)
  end

  def unlike
    @post = Post.find(params[:id])
    @like = current_user.likes.find_by(post: @post)

    authorize! :destroy, @like # Authorize destruction of Like objects

    if @like&.destroy
      @like.update_likes_counter
      flash[:notice] = 'Unliked the post!'
    else
      flash[:error] = 'Failed to unlike the post.'
    end

    redirect_to user_post_path(@user, @post)
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
