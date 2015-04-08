class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_creation_confirmation.subject
  #
  def account_creation_confirmation(user)
    @user = user
    @url  = 'http://example.com/'
    mail to: @user.email, subject: "Welcome to the Gallery"
  end
end
