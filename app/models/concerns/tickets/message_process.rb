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

    def recipients message
      message.to.to_a + message.cc.to_a
    end

    def extract_tenants message
      recipients(message).map { |e| Tenant.find_by email: e }.compact
    end

    def extract_ticket_id message
      extract_subject(message).slice /#(\d+)/, 1
    end

    def extract_subject message
      message.subject.present? ? message.subject : '(no subject)'
    end

    def extract_body message
      reply_delimiter = I18n.t 'response_mailer.reply.reply_delimiter'
      part = extract_part message
      body = part.body.decoded
      body = body.force_encoding(part.charset).encode('UTF-8') if part.charset
      clean_body = body.split(reply_delimiter).first

      clean_body.present? ? clean_body : '-'
    end

    def extract_part message
      message.text_part || message.html_part || message
    end

    def extract_ticket_attributes message
      {
        from: message.from,
        subject: extract_subject(message),
        body: extract_body(message)
      }
    end
  end
end
