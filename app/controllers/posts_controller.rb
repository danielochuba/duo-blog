class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author_id: @user.id)
  end

  def new
    @user = User.find(params[:user_id])
    @user_posts = Post.where(author_id: @user.id)
    @user_post = Post.new

    respond_to do |format|
      format.html { render :new, locals: { user_post: @user_post } }
    end
  end

  def create
    post = @current_user.authored_posts.build(post_params)

    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post created successfully'
          redirect_to user_posts_path(@current_user)
        else
          flash[:error] = 'not created'

          render :new, locals: { user_post: post }
        end
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @user_posts = Post.where(author_id: @user.id)
    @user_post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
