module Tickets::Replies
  extend ActiveSupport::Concern

  included do
    has_many :replies, -> { order 'created_at ASC' }, dependent: :destroy
  end

  def create_reply body
    replies.build body: body, sent_at: Time.now
    reopen

    save!
  end

  private

  def reopen
    self.user_id = nil
    mark_as_open
  end
end
