class ResponseMailer < ActionMailer::Base
  layout 'mailer'
  default from: "'#{I18n.t('app_name')}' <#{APPLICATION['email']}>"

  def reply to: nil, ticket: nil, body: nil
    @ticket, @body, @to = ticket, body, to
    tenant = @ticket.tenant

    attach_smiley_images if @ticket.ask_for_feedback? @to

    mail subject: ticket.subject_with_id, from: tenant.email, to: @to
  end


  private

  def attach_smiley_images
    ['face-smile.png', 'face-plain.png', 'face-sad.png'].each do |image|
      path = Rails.root + 'vendor' + 'assets' + 'images' + image

      attachments.inline[image] = path.read
    end
  end
end
