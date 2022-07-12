# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'testing2@test.com', password: 'qwerty123')
  end

  let(:user_session) do
    session[:user_id] = user.id
  end

  let(:user_verification_ok) do
    get :verify, params: { 'token': user.auth_token }
  end

  let(:user_verification_fails) do
    get :verify, params: { 'token': 'Qwertyuiopasdfghjklzxcvbnmqwertyuioas' }
  end

  describe 'GET /show' do
    it 'returns http success' do
      user_session
      get :show
      json_response = JSON.parse(response.body).first[1]
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(user.id)
    end

    it 'returns http unauthorized when te user is not logged in' do
      get :show
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
  describe 'GET /verify' do
    it 'returns http success ' do
      user_verification_ok
      expect(response).to have_http_status(:no_content)
    end

    it 'returns http error ' do
      user_verification_fails
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
