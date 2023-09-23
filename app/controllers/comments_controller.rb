class CommentsController < ApplicationController

  def index
    post = Post.find(params[:post_id])
    @comments = post.comments
    render json: @comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = @user

    if @comment.save
      render json: @comment, status: :created
      flash[:success] = 'Comment created successfully'
    else
      render json: { errors: @comment.errors.full_messages}, status: :unprocessable_entity
      flash[:error] = 'Comment not created'
    end

    redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted successfully'
    redirect_to user_post_path(user_id: @comment.post.author_id, id: @comment.post.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
