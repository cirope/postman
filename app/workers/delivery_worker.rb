class DeliveryWorker
  include Sidekiq::Worker

  def perform email, ticket_id, message_id
    ticket = Ticket.find ticket_id
    message = Message.find message_id

    ResponseMailer.reply(to: email, ticket: ticket, body: message.body).deliver
    message.touch :sent_at
  end
end
