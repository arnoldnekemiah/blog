class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @new_comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

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
    redirect_to user_posts_path(current_user)
  end

  def like
    @post = Post.find(params[:id])
    @like = current_user.likes.build(post: @post)

    if @like.save
      @like.update_likes_counter
      flash[:notice] = 'Liked the post!'
    else
      flash[:error] = 'Failed to add a like.'
    end

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
