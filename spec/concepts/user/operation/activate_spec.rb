# frozen_string_literal: true

require 'rails_helper'

describe User::Operation::Activate do
  subject(:result) { described_class.call(params: params) }

  context 'with valid data' do
    let(:activation_token) { SecureRandom.urlsafe_base64 }
    let(:email) { 'test@gmail.com' }
    let(:user) do
      User.create(
        email: email,
        activation_token: activation_token,
        password: 'secret',
        password_confirmation: 'secret'
      )
    end

    let(:params) { { activation_token: user.activation_token } }

    it 'is success' do
      expect(result).to be_success
    end

    it 'has email' do
      expect(result['model'].email).to eq(email)
    end

    it 'activates user' do
      expect(result['model'].active).to be true
    end
  end

  context 'with invalid data' do
    let(:params) { { activation_token: '12345' } }

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include('Wrong activation token')
    end
  end

  context 'when user is alredy activated' do
    let(:activation_token) { SecureRandom.urlsafe_base64 }
    let(:email) { 'test@gmail.com' }
    let(:user) do
      User.create(
        email: email,
        activation_token: activation_token,
        active: true,
        password: 'secret',
        password_confirmation: 'secret'
      )
    end

    let(:params) { { activation_token: user.activation_token } }

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include('is already active!')
    end
  end
end
