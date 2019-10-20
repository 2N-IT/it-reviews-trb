require 'rails_helper'

RSpec.describe User::Create do
  let(:params) {
    {
      email: 'hello@gmail.com'
    }
  }

  context 'with valid data' do
    let(:result) { described_class.(params: params) }

    it 'should be success' do
      expect(result.success?).to be true
    end

    it 'should has email' do
      expect(result['model'].email).to eq(params[:email])
    end

    it 'should create user' do
      expect(result['model']).to eq User.last
    end
  end

  context 'with invalid data' do
    let(:result) { described_class.(params: {email: '12345'}) }

    it 'should has failure result' do
      expect(result.failure?).to be true
    end

    it 'should handle an error' do
      error = { email: ['is in invalid format'] }

      expect(result[:errors]).to eq(error)
    end
  end
end
