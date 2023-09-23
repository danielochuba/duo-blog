class PostsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = User.includes(:authored_posts).find(params[:user_id])
    @user_posts = @user.authored_posts
  end

  def like
    @post = Post.find(params[:id]) # Assuming you're using post_id in the route
    @like = @post.likes.build(user: current_user)

    if @like.save
      flash[:success] = 'You liked this post.'
    else
      flash[:error] = 'Failed to like the post.'
    end

    redirect_to @post
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
