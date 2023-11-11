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
    if params[:id] == "new"
      # Redirigir o manejar la lógica para la creación de un nuevo post
      # Por ejemplo, podrías redirigir a la acción 'new' en lugar de renderizar 'show'
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
