# frozen_string_literal: true

class Book < ApplicationRecord
  module Operation
    class Search < OperationBase
      step :params_present?
      fail :empty_params, fail_fast: true
      step :model
      fail :books_undefined

      def params_present?(_options, params:, **)
        params.any?
      end

      def empty_params(options, **)
        options[:errors] = 'Please fill searching fields'
      end

      def model(options, params:, **)
        books = Book
        book_params = {}.tap { |empty_hash| empty_hash.merge!(params.except(:category)) }

        if params.key?(:category)
          books = Book.includes(:categories)
          book_params[:categories] = { name: params[:category] }
        end

        books = books.where(book_params)
        options[:model] = books if books.any?
      end

      def books_undefined(options, **)
        options[:errors] = 'There aren\'t such books'
      end
    end
  end
end
