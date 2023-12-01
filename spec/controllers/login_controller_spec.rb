# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'OAuth Authentication' do
    let(:mock_auth_hash) do
      {
        'provider' => 'google_oauth2',
        'uid'      => '123',
        'info'     => {
          'first_name' => 'John',
          'last_name'  => 'Doe',
          'email'      => 'johndoe@example.com'
        }
      }
    end

    before do
      request.env['omniauth.auth'] = mock_auth_hash
    end

    it 'creates a session for new users' do
      expect { get :google_oauth2 }.to change(User, :count).by(1)
      expect(session[:current_user_id]).not_to be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET #login' do
    it 'renders the login page' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'GET #logout' do
    it 'clears current user sess' do
      session[:current_user_id] = 1
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'Github Authentication' do
    let(:mock_github_auth_hash) do
      {
        'provider' => 'github',
        'uid'      => '321',
        'info'     => {
          'name'  => 'John Smith',
          'email' => 'johnsmith@example.com'
        }
      }
    end

    before do
      request.env['omniauth.auth'] = mock_github_auth_hash
    end

    it 'creates session for github logins' do
      get :github
      expect(session[:current_user_id]).not_to be_nil
      expect(response).to redirect_to(root_url)
    end
  end
end
