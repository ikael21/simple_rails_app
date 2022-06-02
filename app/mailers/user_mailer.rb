class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail(to: @user.email, subject: "Account activation")
  end

  # TODO setup mailer for user to reset their password if needed
  def password_reset
    @greeting = "Hi"

    mail(to: "to@example.org")
  end
end
