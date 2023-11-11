class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user # Make sure current_user is correctly assigned

    puts "Current User ID: #{current_user.id}"
    puts "Comment User ID: #{@comment.user_id}"

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment

    @comment.destroy
    redirect_to user_post_path(@user, @post), notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
