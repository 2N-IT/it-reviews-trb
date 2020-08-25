# frozen_string_literal: true

class User < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :email
      property :password
      property :password_confirmation

      validation do
        schema do
          required(:email).filled(format?: VALID_EMAIL_REGEX)
          required(:password).filled(min_size?: 8)
          required(:password_confirmation).filled(min_size?: 8)
        end

        rule(:password, :password_confirmation) do
          unless values[:password].eql?(values[:password_confirmation])
            key.failure('password does not match password confirmation')
          end
        end
      end
    end
  end
end
