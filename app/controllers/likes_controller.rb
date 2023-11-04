# likes_controller.rb
class LikesController < ApplicationController
    def create
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
  
      if @post.liked_by?(current_user)
        flash[:error] = 'You already liked this post.'
      else
        @like = Like.new(user: current_user, post: @post)
        if @like.save
          flash[:notice] = 'Post liked successfully.'
        else
          flash[:error] = 'Failed to like the post.'
        end
      end
  
      redirect_to user_post_path(@user, @post)
    end
  end
  