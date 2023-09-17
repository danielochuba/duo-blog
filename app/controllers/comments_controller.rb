class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment created successfully'
    else
      flash[:error] = 'Comment not created'
      puts @comment.errors.full_messages.inspect
    end

    redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted successfully'
    redirect_to @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
