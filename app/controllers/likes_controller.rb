class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user , post: @post)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(user_id: @post.author_id, id: @post.id), success: 'Like created successfully' }
      else
        format.html { redirect_to user_post_path(user_id: @post.author_id, id: @post.id), error: 'Like not created' }
      end
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    like = Like.find(params[:id])
    like.destroy if like.user == @user && like.post == post
    @like = Like.find(params[:id])
    @like.destroy
    flash[:success] = 'Like deleted successfully'
    redirect_to @like.post
  end

  private

  def like_params
    params.require(:like).permit(:text)
  end
end
