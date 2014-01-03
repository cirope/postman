require 'mail'

namespace :email do
  desc 'Fetch and convert emails into tickets'
  task fetch: :environment do
    config

    Mail.all.each do |message|
      begin
        Ticket.receive_mail message
      rescue Exception => exception
        log exception, message
      end
    end
  end

  private

  def config
    Mail.defaults do
      retriever_method :pop3, address:    'pop.gmail.com',
                              port:       995,
                              user_name:  APPLICATION['smtp']['user_name'],
                              password:   APPLICATION['smtp']['password'],
                              enable_ssl: true
    end
  end

  def log exception, message
    logger = Logger.new 'log/mailman.log'

    logger.error "Exception occurred while receiving message:\n#{message}"
    logger.error [exception, *exception.backtrace].join("\n")
  end
end
