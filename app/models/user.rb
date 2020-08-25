# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :books, dependent: :nullify, inverse_of: :creator,
                   foreign_key: :creator_id
end
