# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include SessionsHelper

  let!(:user) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'testing2@test.com', password: 'qwerty123',
                verified: true, verification_date: DateTime.now)
  end

  let!(:user_not_verified) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'notverified@test.com', password: 'qwerty123')
  end

  describe 'GET /user/profile' do
    it 'returns http success' do
      login(user)
      get '/api/user/profile'
      json_response = JSON.parse(response.body).first[1]
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(user.id)
    end

    it 'returns http unauthorized when te user is not logged in' do
      get '/api/user/profile'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /verify' do
    it 'returns http success ' do
      get '/api/user/verify', params: { 'token': user_not_verified.auth_token }
      expect(response).to have_http_status(:no_content)
    end

    it 'returns http error ' do
      get '/api/user/verify', params: { 'token': 'Qwertyuiopasdfghjklzxcvbnmqwertyuioas' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
