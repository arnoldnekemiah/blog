def create
  @user = User.find(params[:user_id])
  @post = Post.find(params[:post_id])

  if @post.liked_by?(current_user)
    @post.unliked_by(current_user)
  else
    @post.liked_by(current_user)
  end

  redirect_to user_post_path(@user, @post)
end
