# frozen_string_literal: true

class Book < ApplicationRecord
  module Operation
    class Search < OperationBase
      step :create_book_params
      fail :show_errors, fail_fast: true
      step :model
      fail :books_undefined

      def create_book_params(options, params:, **)
        book_params = {}
        book_params[:title] = params[:title] if params[:title]
        book_params[:author] = params[:author] if params[:author]
        book_params[:categories] = { name: params[:category] } if params[:category]
        options[:book_params] = book_params if book_params.any?
      end

      def show_errors(options, **)
        options[:errors] = 'Please fill searching fields'
      end

      def model(options, book_params:, **)
        books = book_params[:categories] ? Book.includes(:categories) : Book
        books = books.where(book_params)
        options[:model] = books if books.any?
      end

      def books_undefined(options, **)
        options[:errors] = 'There aren\'t such books'
      end
    end
  end
end
