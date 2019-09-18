require 'rails_helper'

RSpec.describe User::Create do
  let(:email) { 'hello@gmail.com' }

  context 'valid data' do
    let(:result) { described_class.(email: email) }

    it 'should be success' do
      assert result.success?
    end

    it 'should have email' do
      assert_equal email, result["model"].email
    end

    it 'should create user' do
      new_user = result['model']
      last_user = User.last

      expect(new_user).to eq last_user
    end
  end

  context 'invalid data' do
    let(:result) { described_class.(email: 12345) }

    it 'should has failure result' do
      assert result.failure?
    end

    it 'should has an error' do
      assert_equal [:email],
        result["contract.default"].errors.messages.keys
    end
  end
end
