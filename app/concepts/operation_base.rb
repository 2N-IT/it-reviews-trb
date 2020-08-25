# frozen_string_literal: true

class OperationBase < Trailblazer::Operation
  def handle_validation_errors!(options, **)
    details = options['contract.default'].errors.messages
    options[:errors] = "Validation failed: #{details}"
  end
end
