class User < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :email

      validation do
        required(:email).filled(format?: VALID_EMAIL_REGEX)
      end
    end
  end
end
