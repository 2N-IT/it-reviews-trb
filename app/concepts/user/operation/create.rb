# frozen_string_literal: true

class User < ApplicationRecord
  module Operation
    class Create < OperationBase
      class Present < OperationBase
        pass Model(User, :new)
        step self::Contract::Build(constant: User::Contract::Create)
      end

      step Subprocess(Present)
      step self::Contract::Validate()
      fail :handle_validation_errors!
      pass :generate_activation_token!
      step self::Contract::Persist()
      step :send_email!

      def generate_activation_token!(options, **)
        loop do
          options['model'].activation_token = SecureRandom.urlsafe_base64

          break unless User.exists?(
            activation_token: options['model'].activation_token
          )
        end
      end

      def send_email!(_options, params:, **)
        user = User.find_by(email: params[:email])
        UserMailer.with(user: user).welcome_email.deliver_now
      end
    end
  end
end
