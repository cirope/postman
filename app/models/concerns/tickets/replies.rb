module Tickets::Replies
  extend ActiveSupport::Concern

  included do
    has_many :replies, dependent: :destroy
  end

  def create_reply message
    replies.create! body: message.body.decoded
  end
end
