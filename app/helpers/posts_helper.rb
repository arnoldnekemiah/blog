module PostsHelper
  def like_post_link(post, user)
    if post.liked_by?(user)
      link_to 'Likes', user_post_like_path(user, post), method: :delete, class: 'like-link'
    else
      link_to 'Like', user_post_like_path(user, post), method: :post, class: 'like-link'
    end
  end
end
