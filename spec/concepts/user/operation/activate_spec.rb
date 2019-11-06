require 'rails_helper'

RSpec.describe User::Operation::Activate do

  context 'with valid data' do
    before do
      @activation_token = SecureRandom.urlsafe_base64
      @user = User.create(
        email:                 'test3@gmail.com',
        activation_token:      @activation_token,
        password:              'secret',
        password_confirmation: 'secret'

      )

      @params = { activation_token: @user.activation_token }
    end

    let(:result) { described_class.(params: @params) }

    it 'should be success' do
      expect(result).to be_success
    end

    it 'should has email' do
      expect(result['model'].email).to eq(@user.email)
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

  context 'user is alredy activated' do
    before do
      @activation_token = SecureRandom.urlsafe_base64
      @user = User.create(
        email:                 'test3@gmail.com',
        activation_token:      @activation_token,
        active:                true,
        password:              'secret',
        password_confirmation: 'secret'
      )

      @params = { activation_token: @user.activation_token }
    end

    let(:result) { described_class.(params: @params) }

    it 'should has failure result' do
      expect(result).to be_failure
    end

    it 'should handle an error' do
      expect(result[:errors]).to include('is already active!')
    end
  end
end
