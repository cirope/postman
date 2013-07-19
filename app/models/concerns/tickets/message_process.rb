module Tickets::MessageProcess
  extend ActiveSupport::Concern

  module ClassMethods
    def receive_mail message
      ticket_id = extract_ticket_id(message)

      if ticket_id && exists?(ticket_id)
        update ticket_id, body: message.body.decoded
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
      domains = message.to.map { |address| address.slice(/@(.+)\z/, 1) }

      domains.map { |d| Tenant.find_by domain: d }.compact
    end

    def extract_ticket_id message
      message['X-Ticket-ID'].decoded if message['X-Ticket-ID']
    end

    def extract_ticket_attributes message
      {
        from: message.from,
        subject: message.subject,
        body: (message.text_part || message.html_part || message).body.decoded
      }
    end
  end
end
