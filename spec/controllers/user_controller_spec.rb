# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let!(:user) do
    User.create!(first_name: 'John',
                 last_name:  'Doe',
                 uid:        '123',
                 provider:   User.providers[:google_oauth2])
  end

  describe 'GET #profile' do
    before do
      session[:current_user_id] = user.id
      get :profile
    end

    it 'responds with 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
