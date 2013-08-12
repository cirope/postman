module Tickets::Scopes
  extend ActiveSupport::Concern

  included do
    scope :sorted, -> { order 'created_at ASC' }
    scope :open, -> { where status: 'open' }
  end

  module ClassMethods
    def loose_or_for user
      open.where user_id: [nil, user.id]
    end
  end
end
