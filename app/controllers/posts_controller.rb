class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author_id: @user.id)
   # @posts_comments = Comment.where(user_id: )
  end

  def show
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author_id: @user.id)
    @user_post = Post.find(params[:id])
  end
end
