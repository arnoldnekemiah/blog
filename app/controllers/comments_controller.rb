class CommentsController < ApplicationController
  before_action :load_post, only: [:create]
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    render json: @comments, except: %i[created_at updated_at]
  end

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      render json: @comment, status: :created, location: user_post_comment_path(@user, @post, @comment)
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    if @comment.destroy
      render json: { notice: 'Comment was successfully deleted.' }
    else
      render json: { error: 'Failed to delete the comment.' }, status: :unprocessable_entity
    end
  end

  private

  def load_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
