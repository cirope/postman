module Tickets::MessageProcess
  extend ActiveSupport::Concern

  module ClassMethods
    def receive_mail message
      ticket_id = extract_ticket_id message

      if ticket_id && exists?(ticket_id)
        find(ticket_id).create_reply extract_body(message)
      else
        create_from_message message
      end
    end

    private

    def create_from_message message
      tenants = extract_tenants message

      raise 'Can not do it without a tenant' if tenants.empty?

      tenants.each do |tenant|
        tenant.tickets.create! extract_ticket_attributes(message)
      end
    end

    def extract_tenants message
      message.to.map { |e| Tenant.find_by email: e }.compact
    end

    def extract_ticket_id message
      message.subject.slice /#(\d+)/, 1
    end

    def extract_body message
      reply_delimiter = I18n.t('response_mailer.reply.reply_delimiter')

      extract_part(message).split(reply_delimiter).first
    end

    def extract_part message
      (message.text_part || message.html_part || message).body.decoded
    end

    def extract_ticket_attributes message
      { from: message.from, subject: message.subject, body: extract_body(message) }
    end
  end
end
