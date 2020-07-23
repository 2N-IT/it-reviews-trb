# frozen_string_literal: true

class Book < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :author
      property :title
      property :publisher
      property :created_by_user_id

      validation do
        option :form

        schema do
          required(:title).filled(:str?)
          required(:created_by_user_id).filled
          required(:author).filled(:str?)
        end

        rule(:title) do
          record = form.model
          if record.class.find_by(author: values[:author], title: value).present?
            key.failure('We have such book with this author already')
          end
        end
      end
    end
  end
end
