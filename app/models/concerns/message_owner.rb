module MessageOwner
  extend ActiveSupport::Concern

  included do
    has_one :message, as: :owner

    delegate :body, :body=, :sent_at, :sent_at=, to: :message
  end

  def message
    super || build_message
  end
end
