module Tickets::Email
  extend ActiveSupport::Concern

  def send_emails message
    @ticket.from.each do |email|
      DeliveryWorker.perform_async email, @ticket.id, message.id
    end
  end
end
