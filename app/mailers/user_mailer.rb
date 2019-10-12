class UserMailer < ApplicationMailer
  def welcome_email(model)
    mail(
      to:           model.email,
      body:         body,
      subject:      'Welcome!',
      content_type: 'text/html'
    )
  end

  def body
    'Welcome to My Awesome Site'
  end
end

# TODO: create link to users/activate and change active: to true
