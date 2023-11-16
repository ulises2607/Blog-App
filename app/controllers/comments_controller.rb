class CommentsController < ApplicationController
  before_action :find_user
  before_action :find_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = @user.comments.build(comment_params.merge(post_id: @post.id))
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  private

  def find_user
    @user = current_user
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
