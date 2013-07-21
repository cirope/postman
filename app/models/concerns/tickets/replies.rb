module Tickets::Replies
  extend ActiveSupport::Concern

  included do
    has_many :replies, -> { order 'created_at ASC' }, dependent: :destroy
  end

  def create_reply body
    replies.create! body: body
  end
end
