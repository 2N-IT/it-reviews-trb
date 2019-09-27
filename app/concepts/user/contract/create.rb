class User < ApplicationRecord
  module Contract
    class Create < Reform::Form
      include Dry
      property :email

      VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

      validation email: :default do
        required(:email).filled(format?: VALID_EMAIL_REGEX)
      end
    end
  end
end
