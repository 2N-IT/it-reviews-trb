class User::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: User::Contract::Create)
  step Contract::Validate()
  fail :validation_errors!
  step Contract::Persist()
  fail :persisting_errors!
  step :send_email!

  def validation_errors!(options, **)
    options[:errors] = options['contract.default'].errors.messages
  end

  def persisting_errors!(options, **)
    options[:errors] = options['contract.default'].errors.messages
  end

  def send_email!(options, model:, **)
    UserMailer.welcome_email(model).deliver_now
  end
end
