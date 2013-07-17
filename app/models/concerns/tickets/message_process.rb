module Tickets::MessageProcess
  extend ActiveSupport::Concern

  module ClassMethods
    def receive_mail message
      ticket_id = message['X-Ticket-ID']

      if ticket_id && exists?(ticket_id.decoded)
        update ticket_id.decoded, body: message.body.decoded
      else
        create_from_message message
      end
    end

    private

    def create_from_message message
      create!(
        from: message.from, subject: message.subject, body: message.body.decoded
      )
    end
  end
end
