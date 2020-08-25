# frozen_string_literal: true

class BookCategory < ApplicationRecord
  belongs_to :book
  belongs_to :category
end
