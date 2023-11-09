class PostsController < ApplicationController
    before_action :find_user, only: [:index, :show]


    def index
        @posts = Post.all
    end

    def show
        @post = @user.posts.find_by(id: params[:id])
    end

    def find_user
        @user = User.find_by(id: params[:user_id])
    end

end
