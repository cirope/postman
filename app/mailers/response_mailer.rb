class ResponseMailer < ActionMailer::Base
  default from: "'#{I18n.t('app_name')}' <#{APP_CONFIG['email']}>"

  def reply ticket, body
    @body = body

    mail subject: ticket.subject_with_id, to: ticket.from
  end
end
