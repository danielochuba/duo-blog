class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user, post: @post)

    respond_to do |format|
      if @like.save
        flash[:success] = 'Like created successfully'
      else
        flash[:error] = 'Like not created'
      end
      format.html { redirect_to user_post_path(user_id: @post.author_id, id: @post.id) }
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
