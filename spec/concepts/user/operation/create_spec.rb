require 'rails_helper'

RSpec.describe User::Operation::Create do

  context 'with valid data' do
    let(:params) {
      {
        email:                 'hello@gmail.com',
        password:              'secretsecret',
        password_confirmation: 'secretsecret'
      }
    }

    let(:result) { described_class.(params: params) }

    it 'should be success' do
      expect(result).to be_success
    end

    it 'should has email' do
      expect(result['model'].email).to eq(params[:email])
    end

    it 'should create user' do
      expect(result['model']).to eq User.last
    end

    it "sends an email" do
      expect { result }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'with invalid email' do
    let(:params) {
      {
        email:                 '12345',
        password:              'secretsecret',
        password_confirmation: 'secretsecret'
      }
    }

    let(:result) { described_class.(params: params) }

    it 'should has failure result' do
      expect(result).to be_failure
    end

    it 'should handle an error' do
      error = 'is in invalid format'
      expect(result[:errors]).to include(error)
    end
  end

  context 'with invalid password' do
    let(:params) {
      {
        email:                 'hello@gmail.com',
        password:              'secret',
        password_confirmation: 'secret'
      }
    }

    let(:result) { described_class.(params: params) }

    it 'should has failure result' do
      expect(result).to be_failure
    end

    it 'should handle an error' do
      error = 'size cannot be less than 12'
      expect(result[:errors]).to include(error)
    end
  end
end
