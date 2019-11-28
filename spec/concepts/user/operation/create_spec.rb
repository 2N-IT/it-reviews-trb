# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::Operation::Create do
  subject(:result) { described_class.call(params: params) }

  context 'with valid data' do
    let(:params) do
      {
        'user' => {
          email:                 'hello@gmail.com',
          password:              'secretsecret',
          password_confirmation: 'secretsecret'
        }
      }
    end

    it 'is success' do
      expect(result).to be_success
    end

    it 'should has email' do
      expect(result['model'].email).to eq('hello@gmail.com')
    end

    it 'creates user' do
      expect(result['model']).to eq User.last
    end

    it 'sends an email' do
      expect { result }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'with invalid email' do
    let(:params) do
      {
        'user' => {
          email:                 '12345',
          password:              'secretsecret',
          password_confirmation: 'secretsecret'
        }
      }
    end

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      error = 'is in invalid format'
      expect(result[:errors]).to include(error)
    end
  end

  context 'with invalid password' do
    let(:params) do
      {
        'user' => {
          email:                 'hello@gmail.com',
          password:              'secret',
          password_confirmation: 'secret'
        }
      }
    end

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      error = 'size cannot be less than 8'
      expect(result[:errors]).to include(error)
    end
  end
end
