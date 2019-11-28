# frozen_string_literal: true

class User < ApplicationRecord
  module Operation
    class Create < Trailblazer::Operation
      class Present < Trailblazer::Operation
        step Model(User, :new)
        step self::Contract::Build(constant: User::Contract::Create)
      end

      step Subprocess(Present)
      step self::Contract::Validate(key: 'user')
      fail :handle_errors!
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

      def handle_errors!(options, **)
        details = options['contract.default'].errors.messages
        options[:errors] = "Validation failed: #{details}"
      end

      def send_email!(options, model:, **)
        UserMailer.with(user: model).welcome_email.deliver_now
      end
    end
  end
end
