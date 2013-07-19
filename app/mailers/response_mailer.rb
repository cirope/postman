class ResponseMailer < ActionMailer::Base
  default from: "'#{I18n.t('app_name')}' <#{APP_CONFIG['email']}>"

  def reply ticket, body
    @body = body
    tenant = ticket.tenant

    mail subject: ticket.subject_with_id, from: tenant.email, to: ticket.from
  end
end
