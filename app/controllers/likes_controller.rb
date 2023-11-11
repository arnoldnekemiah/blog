class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)

    authorize! :create, @like # Authorize creation of Like objects

    if @like.save
      @like.update_likes_counter
      flash[:notice] = 'Liked the post!'
    else
      flash[:error] = 'Failed to add a like.'
    end

    redirect_to user_post_path(@user, @post)
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.find_by(user: current_user, post: @post)

    authorize! :destroy, @like # Authorize destruction of Like objects

    if @like&.destroy
      @like.update_likes_counter
      flash[:notice] = 'Unliked the post!'
    else
      flash[:error] = 'Failed to unlike the post.'
    end

    redirect_to user_post_path(@user, @post)
  end
end
