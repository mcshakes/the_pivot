class UserMailer < ApplicationMailer
  def account_creation_confirmation(user)
    @user = user
    @url  = 'http://example.com/'
    mail to: @user.email, subject: "Welcome to the Gallery"
  end
end
