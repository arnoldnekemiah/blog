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
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    if @comment.destroy
      flash[:notice] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Failed to delete the comment.'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
