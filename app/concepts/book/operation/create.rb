# frozen_string_literal: true

class Book < ApplicationRecord
  module Operation
    class Create < OperationBase
      class Present < OperationBase
        pass Model(Book, :new)
        step self::Contract::Build(constant: Book::Contract::Create)
      end

      step Subprocess(Present)
      step :add_created_by_user_id_to_params
      step self::Contract::Validate()
      fail :handle_validation_errors!
      step self::Contract::Persist()

      def add_created_by_user_id_to_params(_options, params:, **)
        params[:created_by_user_id] = params[:user][:id]
      end
    end
  end
end
