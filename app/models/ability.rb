class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
    if user.admin?
      can :manage, :all
    else
      can :create, [Post, Comment, Like]
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
      can :destroy, Like, user_id: user.id

    end
  end
end
