class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    set_attachment
    mail(:to => user.email, :subject => 'Your password has been reset')
  end

  def goodbye_reason(user)
    @user = User.find user.id
    set_attachment
    mail(to: user.email, subject: 'Kiev-ruby')
  end

  private
    def set_attachment
      attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
    end
end
