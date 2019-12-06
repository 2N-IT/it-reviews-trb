# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :books, dependent: :nullify, inverse_of: :created_by_user,
                   foreign_key: :created_by_user_id
end
