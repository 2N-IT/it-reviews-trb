# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_categories, dependent: :restrict_with_exception
  has_many :categories, through: :book_categories

  belongs_to :creator, class_name: 'User', inverse_of: :books
end
