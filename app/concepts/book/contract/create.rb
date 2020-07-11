# frozen_string_literal: true

class Book < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :author
      property :title
      property :publisher
      property :created_by_user_id

      validation do
        configure do
          config.messages_file = './config/errors.yml'

          def unique_for_author?(author, title)
            Book.find_by(author: author, title: title).blank?
          end
        end

        required(:title).filled(:str?)
        required(:created_by_user_id).filled
        required(:author).filled(:str?)

        rule(title_uniqueness: %i[author title]) do |author, title|
          title.unique_for_author?(author)
        end
      end
    end
  end
end
