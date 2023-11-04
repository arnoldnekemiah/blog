class CommentsController < ApplicationController
 
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params)
        @comment.user = @current_user
      
        if @comment.save
          redirect_to post_path(@post), notice: 'Comment created successfully'
        else
          render 'new'
        end
      end

    def new
        @post = Post.find(params[:post_id])
        @comment = Comment.new
    end
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
  