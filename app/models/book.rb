# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_categories, dependent: :delete_all
  has_many :categories, through: :book_categories

  belongs_to :created_by_user, class_name: 'User', inverse_of: :books
end
