require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user_found_by_email) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'testing@test.com', password: 'qwerty123', verified: true,
                verification_date: DateTime.now)
  end

  let(:request_login_ok) do
    post '/login', params: '{ "email": "testing@test.com", "password": "qwerty123" }',
                   headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_login_not_found_email) do
    post '/login', params: '{ "email": "not_found_email@test.com", "password": "qwerty123" }',
                   headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_login_bad_password) do
    post '/login', params: '{ "email": "testing@test.com", "password": "bad password" }',
                   headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_signup_ok) do
    post '/signup', params: '{ "keywords": ["test"], "password": "signup_password", "name": "Testing Test",
                               "email": "signup@test.com" }', headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_signup_without_name) do
    post '/signup', params: '{ "keywords": ["test"], "password": "signup_password",
                               "email": "signup@test.com" }', headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_signup_without_keywords) do
    post '/signup', params: '{ "password": "signup_password", "name": "Testing Test",
                               "email": "signup@test.com" }', headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_signup_without_email) do
    post '/signup', params: '{ "keywords": ["test"], "password": "signup_password", "name": "Testing Test"}',
                    headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:request_signup_email_registered) do
    post '/signup', params: '{ "keywords": ["test"], "password": "signup_password", "name": "Testing Test",
                               "email": "testing@test.com" }', headers: { 'CONTENT_TYPE' => 'application/json' }
  end

  let(:mail_user) do
    User.find_by_email('signup@test.com')
  end

  describe 'POST /login' do

    it 'returns http success (ok : 200)' do
      request_login_ok
      expect(response).to have_http_status(:ok)
    end

    it 'when email not found returns http unauthorized (error: 401)' do
      request_login_not_found_email
      expect(response).to have_http_status(:unauthorized)
    end

    it 'when bad password returns http unauthorized (error: 401)' do
      request_login_bad_password
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /logout' do
    it 'when logout returns success (ok: no_content) ' do
      post '/logout'
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'POST /signup' do

    it 'returns http success (ok: created)' do
      perform_enqueued_jobs do
        request_signup_ok
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq 'signup@test.com'

      expect(response).to have_http_status(:created)
    end

    it 'when no email returns http bad request (error: bad_request)' do
      request_signup_without_email
      expect(response).to have_http_status(:bad_request)
    end

    it 'when no name returns http bad request (error: bad_request)' do
      request_signup_without_name
      expect(response).to have_http_status(:bad_request)
    end

    it 'when no keywords returns http bad request (error: bad_request)' do
      request_signup_without_keywords
      expect(response).to have_http_status(:bad_request)
    end

    it 'when email is registered returns http bad request (error: bad_request)' do
      request_signup_email_registered
      expect(response).to have_http_status(:bad_request)
    end
  end
end
