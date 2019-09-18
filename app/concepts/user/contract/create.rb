require 'reform/form/dry'

module User::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry
    property :email

    validation :default do
      required(:email).filled(:str?)
    end
  end
end
