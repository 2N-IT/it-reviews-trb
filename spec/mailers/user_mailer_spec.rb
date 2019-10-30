require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome email' do
    before do
      @user = User.create(email: 'test2@gmail.com',
                          activation_token: SecureRandom.urlsafe_base64)
    end

    let(:mail) { described_class.with(user: @user).welcome_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Registration Confirmation')
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Welcome')
    end
  end
end
