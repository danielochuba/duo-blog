module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        post = Post.find(params[:post_id])
        comments = post.comments
        render json: comments
      end

      def create
        post = Post.find(params[:post_id])
        comment = post.comments.build(comment_params)
        comment.user = User.find(params[:user_id]) # Assuming you have user authentication

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
