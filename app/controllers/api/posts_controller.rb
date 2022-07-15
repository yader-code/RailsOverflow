# frozen_string_literal: true

module Api
  class PostsController < ApiController
    skip_before_action :require_login, only: %i[index post_responses]

    def index
      filter_params = query_params
      posts = Post.posts_parents
                  .order(filter_params[:order_by])
                  .page(filter_params[:page])
                  .per(filter_params[:page_size])

      render json: posts, status: :ok
    end

    def post_responses
      filter_params = query_params
      posts = Post.find(filter_params[:id])
                  .posts
                  .order(filter_params[:order_by])
                  .page(filter_params[:page])
                  .per(filter_params[:page_size])

      render json: posts, status: :ok
    end

    def create
      post_params = request_params

      post_params['user'] = current_user

      post = Post.create(post_params)

      if post.errors.present?
        render json: post.errors, status: :bad_request
      else
        render json: post, status: :created
      end
    end

    def update
      post = current_user.posts.find(query_params[:id])

      post.update!(request_params)

      render json: post, status: :ok
    end

    def posts_by_user
      filter_params = query_params
      posts = current_user.posts
                          .order(filter_params[:order_by])
                          .page(filter_params[:page])
                          .per(filter_params[:page_size])

      render json: posts, status: :ok
    end

    private

    def request_params
      params.permit(:title, :content, :post_id)
    end

    def query_params
      params.permit(:page, :page_size, :order_by, :id, :post_id)
    end
  end
end
