class UserMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  layout 'mailer'

  default from: "'#{I18n.t('app_name')}' <#{ENV['EMAIL_ADDRESS']}>"

  def password_reset(user)
    @user = user

    mail to: user.email
  end
end
