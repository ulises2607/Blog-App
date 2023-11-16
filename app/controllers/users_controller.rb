class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order(created_at: :asc)
  end
end
