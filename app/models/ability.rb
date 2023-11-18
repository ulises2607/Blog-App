# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else user.role == 'member'
      can :read, :all
      can :create, Comment
      can :update, Comment, author_id: user.id
      can :create, Like
      can :create, Post
      can :update, Post, author_id: user.id
    end

  end
end
