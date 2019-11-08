require 'rails_helper'

RSpec.describe User::Operation::Activate do

  context 'with valid data' do
    let(:activation_token) { SecureRandom.urlsafe_base64 }
    let(:email) { 'test@gmail.com' }
    let(:user) {
      User.create(
        email:                 email,
        activation_token:      activation_token,
        password:              'secret',
        password_confirmation: 'secret'
      )
    }

    let(:params) { { activation_token: user.activation_token } }
    let(:result) { described_class.(params: params) }

    it 'should be success' do
      expect(result).to be_success
    end

    it 'should has email' do
      expect(result['model'].email).to eq(email)
    end

    it 'should activate user' do
      expect(result['model'].active).to be true
    end
  end

  context 'with invalid data' do
    let(:result) { described_class.(params: {activation_token: '12345'}) }

    it 'should has failure result' do
      expect(result).to be_failure
    end

    it 'should handle an error' do
      expect(result[:errors]).to include('Wrong activation token')
    end
  end

  context 'when user is alredy activated' do
    let(:activation_token) { SecureRandom.urlsafe_base64 }
    let(:email) { 'test@gmail.com' }
    let(:user) {
      User.create(
        email:                 email,
        activation_token:      activation_token,
        active:                true,
        password:              'secret',
        password_confirmation: 'secret'
      )
    }

    let(:params) { { activation_token: user.activation_token } }
    let(:result) { described_class.(params: params) }

    it 'should has failure result' do
      expect(result).to be_failure
    end

    it 'should handle an error' do
      expect(result[:errors]).to include('is already active!')
    end
  end
end
