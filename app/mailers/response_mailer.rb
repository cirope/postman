class ResponseMailer < ActionMailer::Base
  default from: "'#{I18n.t('app_name')}' <#{APP_CONFIG['email']}>"

  def reply to: nil, ticket: nil, body: nil
    tenant = ticket.tenant
    @ticket = ticket
    @body = body
    @to = to
    attach_smile_image

    mail subject: ticket.subject_with_id, from: tenant.email, to: @to
  end


  private

  def attach_smile_image
    path = File.join Rails.root, 'vendor', 'assets', 'images', 'face-smile.png'

    attachments.inline['smile.png'] = File.read path
  end
end
