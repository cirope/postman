class DeliveryWorker
  include Sidekiq::Worker

  def perform email, ticket_id, body
    ticket = Ticket.find ticket_id

    ResponseMailer.reply(to: email, ticket: ticket, body: body).deliver
  end
end
