# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    sequence(:uid) { |n| "uid#{n}" }
    provider { User.providers.keys.sample }
  end
end

RSpec.describe User, type: :model do
  describe '#name' do
    it 'returns the full name of the user' do
      user = build(:user, first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq 'John Doe'
    end
  end

  describe '#auth_provider' do
    it 'returns the correct auth provider name for google_oauth2' do
      user = build(:user, provider: 'google_oauth2')
      expect(user.auth_provider).to eq 'Google'
    end

    it 'returns the correct auth provider name for github' do
      user = build(:user, provider: 'github')
      expect(user.auth_provider).to eq 'Github'
    end
  end

  describe '.find_google_user' do
    it 'finds a user with google_oauth2 provider' do
      user = create(:user, provider: 'google_oauth2', uid: '123456')
      expect(described_class.find_google_user('123456')).to eq user
    end
  end

  describe '.find_github_user' do
    it 'finds a user with github provider' do
      user = create(:user, provider: 'github', uid: '654321')
      expect(described_class.find_github_user('654321')).to eq user
    end
  end
end
