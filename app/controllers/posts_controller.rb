class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @posts = @user.posts
    else
      @posts = Post.all
    end
  end

  def show
    @post = @user.posts.find_by(id: params[:id])
    @next_post = @user.posts.where('id > ?', @post.id).first

    Rails.logger.debug "Current post: #{@post.inspect}"
    Rails.logger.debug "Next post: #{@next_post.inspect}"
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end
