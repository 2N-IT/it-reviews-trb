# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book::Operation::Search do
  include Trailblazer::Test::Deprecation::Operation::Helper

  subject(:result) { described_class.call(params: params) }

  let(:category_name) { 'ruby' }
  let(:user) { factory(User::Operation::Create, params: user_params)[:model] }
  let(:user_params) do
    {
      email: 'hello@gmail.com',
      password: 'secretsecret',
      password_confirmation: 'secretsecret'
    }
  end

  context 'with valid data' do
    let(:params) do
      {
        author: 'Sendi Metz',
        title: 'great book',
        category: category_name,
        creator_id: user.id
      }
    end

    context 'when all fields are provided' do
      before do
        ruby_category = Category.create!(name: category_name)
        book = factory(Book::Operation::Create, params: params)[:model]
        BookCategory.create(book: book, category: ruby_category)
      end

      it 'is success' do
        expect(result).to be_success
      end

      it 'has the author' do
        expect(result['model'].first.author).to eq(params[:author])
      end
    end

    context 'when not all fields are provided' do
      before do
        ruby_category = Category.create!(name: category_name)
        book = factory(Book::Operation::Create, params: params)[:model]
        params.delete(:title)
        BookCategory.create(book: book, category: ruby_category)
      end

      it 'is success' do
        expect(result).to be_success
      end

      it 'has the author' do
        expect(result['model'].first.author).to eq(params[:author])
      end
    end
  end

  context 'when specific book is missing' do
    let(:error) { 'There aren\'t such books' }
    let(:params) { { author: 'Sendi Metz' } }

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include(error)
    end
  end

  context 'when user don\'t fill searching fields' do
    let(:error) { 'Please fill searching fields' }
    let(:result) { described_class.call(params: {}) }

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include(error)
    end
  end
end
