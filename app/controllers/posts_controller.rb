class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]

  def index
    per_page = 10
    page = params[:page] || 1

    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @posts = @user.posts.includes(:comments).where(author_id: @user.id).paginate(page: page, per_page: per_page)

      @total_pages = (@posts.total_entries.to_f / per_page).ceil
      @author = @posts.first.user unless @posts.empty?
    else
      @posts = Post.paginate(page: page, per_page: per_page)
    end
  end

  def show
    if params[:id] == 'new'
      redirect_to new_user_post_path(@user)
    else
      @post = @user.posts.find_by(id: params[:id])
      @next_post = @user.posts.where('id > ?', @post.id).first if @post
    end

    Rails.logger.debug "Current post: #{@post.inspect}"
    Rails.logger.debug "Next post: #{@next_post.inspect}"
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
