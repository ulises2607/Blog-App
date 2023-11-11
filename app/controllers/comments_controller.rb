class CommentsController < ApplicationController

    def new
        @user = current_user
        @post = Post.find(params[:post_id])
        @comment = Comment.new
    end

    def create
        @user = current_user
        @post = Post.find(params[:post_id])
        @comment = @user.comments.build(params.require(:comment).permit(:text).merge(post_id: @post.id))
        if @comment.save
            redirect_to user_post_path(@user, @post)
        else
            render :new
        end
    end



end
