module Tickets::Email
  extend ActiveSupport::Concern

  def send_emails body
    @ticket.from.each do |email|
      ResponseMailer.delay.reply to: email, ticket: @ticket, body: body
    end
  end
end
