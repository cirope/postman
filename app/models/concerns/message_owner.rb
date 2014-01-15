module MessageOwner
  extend ActiveSupport::Concern

  included do
    before_create :build_default_message

    has_one :message, as: :owner

    delegate :body, :body=, :sent_at, :sent_at=, to: :message, prefix: true
  end

  private

    def build_default_message
      build_message
    end
end
