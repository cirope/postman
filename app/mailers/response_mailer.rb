class ResponseMailer < ActionMailer::Base
  default from: "'#{I18n.t('app_name')}' <#{APP_CONFIG['email']}>"

  def reply to: nil, ticket: nil, body: nil
    tenant = ticket.tenant
    @ticket = ticket
    @body = body
    @to = to

    mail subject: ticket.subject_with_id, from: tenant.email, to: @to
  end
end
