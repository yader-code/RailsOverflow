# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include SessionsHelper

  let!(:user_with_posts) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'testing@test.com', password: 'qwerty123', verified: true,
                verification_date: DateTime.now)
  end

  let!(:user_without_posts) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'withoutposts@test.com', password: 'qwerty123',
                verified: true, verification_date: DateTime.now)
  end

  let!(:parent_post) do
    Post.create(title: 'Parent post', content: 'This is a parent post test', user: user_with_posts)
  end

  let!(:child_post) do
    Post.create(title: 'Child post', content: 'This is a child post test', user: user_with_posts,
                post_id: parent_post.id)
  end

  let!(:user_with_posts_two) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'withpost2@test.com', password: 'qwerty123', verified: true,
                verification_date: DateTime.now)
  end
  let!(:child_post_two) do
    Post.create(title: 'Child two', content: 'this is the second child post', user: user_with_posts_two,
                post_id: parent_post.id)
  end

  # <<<<<<< CREATION POST TESTS >>>>>>
  describe 'POST /posts' do
    it 'return http created for a parent post' do
      login(user_with_posts)
      post '/api/posts', params: '{ "title": "This is a test", "content": "unit test for post creation" }',
                         headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(:created)
    end

    it 'return http created for a child post' do
      login(user_with_posts)

      perform_enqueued_jobs do
        post '/api/posts',
             params: { title: 'Child post', content: 'unit test for post creation to send emails',
                       post_id: parent_post.id }.to_json,
             headers: { 'CONTENT_TYPE' => 'application/json' }
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user_with_posts_two.email

      expect(response).to have_http_status(:created)
    end

    it 'return http bad_request' do
      login(user_with_posts)
      post '/api/posts', params: '{ "title": "This is a test" }',
                         headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(:bad_request)
    end

    it 'return http unauthorized' do
      post '/api/posts', params: '{ "title": "This is a test", "content": "unit test for post creation" }',
                         headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  # <<<<<<< UPDATING POST TESTS >>>>>>
  describe 'PUT /posts' do
    it 'return http ok' do
      login(user_with_posts)
      put "/api/posts/#{parent_post.id}",
          params: '{ "title": "This is a test", "content": "unit test for post creation" }',
          headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(:ok)
    end

    it 'return http ok' do
      login(user_with_posts)
      put "/api/posts/#{parent_post.id}",
          params: '{ "title": "This is a test" }',
          headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(:ok)
    end

    it 'return http not_found' do
      login(user_without_posts)
      put "/api/posts/#{parent_post.id}",
          params: '{ "title": "This is a test", "content": "unit test for post creation" }',
          headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(:not_found)
    end
  end

  # <<<<<<< GETTING POST TESTS >>>>>>
  describe 'GET /posts' do
    it 'return all parent posts http ok ' do
      get '/api/posts'
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return all responses for a post http ok ' do
      get "/api/posts/#{parent_post.id}/responses"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return http not found when child parent does not exist ' do
      get '/api/posts/1/responses'
      expect(response).to have_http_status(:not_found)
    end

    it 'return all posts that belongs to a user ' do
      login(user_with_posts)
      get '/api/user/posts'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'return http ok when user does not have posts ' do
      login(user_without_posts)
      get '/api/user/posts'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end
  end
end
