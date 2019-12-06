# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :book_categories, dependent: :delete_all
  has_many :books, through: :book_categories
end
