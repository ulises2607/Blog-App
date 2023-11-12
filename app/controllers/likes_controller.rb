class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user, post: @post)

    if @like.save
      redirect_to user_post_path(@user, params[:post_id])
    else
      render :new
    end
  end
end
