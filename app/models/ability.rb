class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.present?

    can :manage, [Post, Comment], user: user
    can :destroy, Comment, post: user.posts
    can :read, Post
    can [:read, :update], User, id: user.id
    can :manage, Like

    return unless user.admin?

    can :manage, :all
  end
end