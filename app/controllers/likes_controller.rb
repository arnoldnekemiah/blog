class LikesController < ApplicationController
    def create
        @like = @user.likes.build(post_id: params[:post_id])
        if @like.save
          redirect_to post_path(params[:post_id]), notice: 'Liked the post!'
        else
          redirect_to post_path(params[:post_id]), alert: 'Failed to like the post.'
        end
      end
      
      def destroy
        @like = @user.likes.find_by(post_id: params[:post_id])
        if @like
          @like.destroy
          redirect_to post_path(params[:post_id]), notice: 'Unliked the post.'
        else
          redirect_to post_path(params[:post_id]), alert: 'Failed to unlike the post.'
        end
      end
end
