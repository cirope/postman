module Tickets::Scopes
  extend ActiveSupport::Concern

  included do
    scope :sorted, -> { order('created_at ASC') }
  end

  module ClassMethods
    def for user
      where(user_id: [nil, user.id])
    end
  end
end
