class Api::V1::LikesController < ApplicationController
  before_action :set_like, only: %i[show update destroy]

  # GET /likes
  def index
    @likes = Like.all

    render json: @likes
  end

  # GET /likes/1
  def show
    render json: @like
  end

  # POST /likes
  def create
    model = post_or_comment
    like = Like.new(like_params)

    like.likeable = model
    like.user = current_user

    if like.save
      render json: like, status: :created
    else
      render json: like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /likes/1
  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    if @like.destroy
      render json: 'dislike'
    else
      render json: 'cant dislike'
    end
  end

  private

  def post_or_comment
    return Post.find(params[:post_id]) if params[:post_id]

    Comment.find(params[:comment_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.fetch(:like).permit(:liked)
  end
end
