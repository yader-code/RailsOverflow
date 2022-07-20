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
        users_emails = get_users_mail(Post.find(request_params[:post_id]).posts) if request_params[:post_id].present?
        unless users_emails.nil?
          UserMailer.with(post_created: post, emails: users_emails)
                    .post_creation_notification_email
                    .deliver_later
        end

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

    def get_users_mail(posts)
      users = []
      posts.pluck(:user_id).uniq.each do |user_id|
        users.append(User.find(user_id).email)
      end
      users
    end

    def request_params
      params.permit(:title, :content, :post_id, :id)
    end
  end
end
