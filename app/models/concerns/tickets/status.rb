module Tickets::Status
  extend ActiveSupport::Concern

  included do
    STATUS = %w(open closed)

    validates :status, inclusion: { in: STATUS }, presence: true

    after_initialize(on: :create) { self.status ||= 'open' }
  end
end
