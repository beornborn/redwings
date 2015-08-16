class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: 'Your password has been reset')
  end

  def goodbye_reason(user)
    @user = User.find user.id
    mail(to: user.email, subject: 'Kiev-ruby')
  end

  def welcome_email(user)
    @user = User.find user.id
    @url  = 'https://trello.com/c/MChhdpLY/343--'
    mail(to: user.email, subject: 'Kiev-ruby')
  end
end
