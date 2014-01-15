namespace :message do
  desc 'Migrate body columns to messages'
  task migrate: :environment do
    Message.transaction do
      Reply.all.each do |reply|
        reply.create_message! body: reply.body
      end

      Ticket.all.each do |ticket|
        ticket.create_message! body: ticket.body
      end
    end
  end
end
