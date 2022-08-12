# frozen_string_literal: true

module Api
  class PostsController < ApiController
    include FilterAndPagination
    skip_before_action :require_login, only: %i[index post_responses show]

    def index
      posts = get_paginated_and_filtered(Post.posts_parents)

      render json: posts, status: :ok
    end

    def post_responses
      posts = get_paginated_and_filtered(Post.find(request_params[:id]).posts)

      render json: posts, status: :ok
    end

    def create
      post_params = request_params

      post_params['user'] = current_user

      post = Post.create(post_params)

      if post.errors.present?
        render json: post.errors, status: :bad_request
      else
        UserMailer.with(post_created: post).post_creation_notification_email.deliver_later if post.post_id.present?
        render json: post, status: :created
      end
    end

    def update
      post = current_user.posts.find(request_params[:id])

      post.update!(request_params)

      render json: post, status: :ok
    end

    def posts_by_user
      posts = get_paginated_and_filtered(current_user.posts)
      render json: posts, status: :ok
    end

    def show
      post = Post.find(request_params[:id])
      render json: post, status: :ok
    end

    private

    def request_params
      params.permit(:title, :content, :post_id, :id)
    end
  end
end
