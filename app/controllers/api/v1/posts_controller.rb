module Api
  module V1
    class PostsController < ApplicationController
      def index
        user = User.find(params[:user_id])
        posts = user.authored_posts
        render json: posts
      end
    end
  end
end
