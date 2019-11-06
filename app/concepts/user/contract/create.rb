class User < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :email
      property :password
      property :password_confirmation

      validation do
        required(:email).filled(format?: VALID_EMAIL_REGEX)
        required(:password).filled(min_size?: 12).confirmation
      end
    end
  end
end
