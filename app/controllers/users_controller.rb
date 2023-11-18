class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :index, User

    redirect_to user_path(current_user) if current_user && !current_user.admin?

    @users = User.includes(:posts).all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order(created_at: :asc)
  end
end
