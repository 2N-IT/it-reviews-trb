# frozen_string_literal: true

class Book < ApplicationRecord
  module Operation
    class Create < OperationBase
      class Present < OperationBase
        pass Model(Book, :new)
        step self::Contract::Build(constant: Book::Contract::Create)
      end

      step Subprocess(Present)
      step self::Contract::Validate()
      fail :handle_validation_errors!
      step self::Contract::Persist()
    end
  end
end
