# frozen_string_literal: true

# TODO: update dry-validation gem and use high-rule for unique_title_for_author
class Book < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :author
      property :title
      property :publisher
      property :created_by_user_id

      validation name: :unique, with: { form: true } do
        configure do
          config.messages_file = './config/errors.yml'

          def unique_title_for_author?(author)
            Book.find_by(author: author, title: form.title).nil?
          end
        end

        required(:title).filled(:str?)
        required(:created_by_user_id).filled
        required(:author).filled(:unique_title_for_author?)
      end
    end
  end
end
