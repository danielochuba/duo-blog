class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)

    puts @like.inspect

    if @like.save
      flash[:success] = 'Like created successfully'
    else
      flash[:error] = 'Like not created'
      puts @like.errors.full_messages.inspect, 'cant save like'
    end

    redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = Like.find(params[:id])
    like.destroy if like.user == current_user && like.post == post
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
