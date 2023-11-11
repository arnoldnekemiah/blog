class PostsController < ApplicationController
  load_and_authorize_resource except: %i[like unlike]
  before_action :set_user
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    render json: @posts, except: %i[created_at updated_at]
  end

  def show
    @comments = @post.comments
    @show ||= Comment.new(user: current_user, post: @post) # Initialize with the current post
    render json: { post: @post, comments: @comments }, except: %i[created_at updated_at]
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.build(post_params)
    @post.user_id = @user.id # Set the user_id explicitly
    if @post.save
      render json: @post, status: :created, location: user_post_path(@user, @post)
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @post
    if @post.destroy
      render json: { notice: 'Post was successfully deleted.' }
    else
      render json: { error: 'Failed to delete the post.' }, status: :unprocessable_entity
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = current_user.likes.find_or_initialize_by(post: @post)
    authorize! :create, Like # Authorize creation of Like objects
    if @like.save
      @like.update_likes_counter
      render json: { notice: 'Liked the post!' }
    else
      render json: { error: 'Failed to like the post.' }, status: :unprocessable_entity
    end
  end

  def unlike
    @post = Post.find(params[:id])
    @like = current_user.likes.find_by(post: @post)
    authorize! :destroy, @like # Authorize destruction of Like objects
    if @like&.destroy
      @like.update_likes_counter
      render json: { notice: 'Unliked the post!' }
    else
      render json: { error: 'Failed to unlike the post.' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    return if @user

    render json: { error: 'User not found' }, status: :not_found
  end

  def set_post
    @post = @user.posts.find_by(id: params[:id])
    return if @post

    render json: { error: 'Post not found' }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
