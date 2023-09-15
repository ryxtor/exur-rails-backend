module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show update destroy]
      before_action :authenticate_user!

      # GET /posts
      def index
        @posts = current_user.posts
        @posts = @posts.map { |post| post_data(post) }
        render json: @posts
      end

      # GET /posts/1
      def show
        @post = post_data(@post)
        render json: @post
      end

      # POST /posts
      def create
        @post = Post.new(post_params)

        @post.user = current_user

        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /posts/1
      def destroy
        if @post.destroy
          render json: 'se hizo la borracion'
        else
          render json: 'No se hizo la borracion'
        end
      end

      private

      def post_data(post)
        likes = post.like_count
        {
          id: post.id,
          text: post.text,
          user: post.user.username,
          created_at: post.created_at,
          likes: likes[:likes],
          dislikes: likes[:dislikes],
          comments: post.comments.map do |comment|
            {
              id: comment.id,
              text: comment.text,
              user: comment.user.username,
              likes: comment.like_count[:likes],
              dislikes: comment.like_count[:dislikes],
              created_at: comment.created_at
            }
          end
        }
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:text)
      end
    end
  end
end
