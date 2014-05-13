module MessageOwner
  extend ActiveSupport::Concern

  included do
    has_one :message, as: :owner

    delegate :body, :body=, :sent_at, :sent_at=, to: :_message
  end

  def _message
    message || build_message
  end
end
