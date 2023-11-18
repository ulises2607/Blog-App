class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :find_user
  before_action :find_post
  before_action :find_comment, only: [:destroy]
  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params.merge(post_id: @post.id))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    @post.comments_counter -= 1
    @post.save
    redirect_to user_post_path(@user, @post), notice: 'Comment was successfully deleted.'
  end

  private

  def find_user
    @user = current_user
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
