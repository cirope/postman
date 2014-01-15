module Tickets::Email
  extend ActiveSupport::Concern

  def send_emails body
    @ticket.from.each do |email|
      DeliveryWorker.perform_async email, @ticket.id, body
    end
  end
end
