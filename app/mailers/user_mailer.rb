class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: "'#{I18n.t('app_name')}' <#{APP_CONFIG['email']}>"

  def password_reset(user)
    @user = user

    mail to: user.email
  end
end
