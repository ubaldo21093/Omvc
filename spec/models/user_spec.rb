require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user registration' do
    it 'creates a new user with valid attributes' do
      user = User.new(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it 'does not create a user with invalid email format' do
      user = User.new(
        email: 'invalid_email',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('is invalid')
    end
  end

  describe 'OAuth authentication' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123456',
        info: {
          email: 'user@example.com',
          name: 'Test User'
        }
      )
    end

    it 'creates a new user from Google OAuth2 data' do
      expect {
        User.from_omniauth(auth)
      }.to change(User, :count).by(1)
    end

    it 'finds an existing user from Google OAuth2 data' do
      existing_user = User.create(
        email: 'user@example.com',
        password: 'password123',
        provider: 'google_oauth2',
        uid: '123456'
      )
      
      user = User.from_omniauth(auth)
      expect(user).to eq(existing_user)
    end
  end
end