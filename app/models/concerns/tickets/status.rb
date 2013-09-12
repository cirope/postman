module Tickets::Status
  extend ActiveSupport::Concern

  included do
    STATUS = %w(open closed)

    validates :status, inclusion: { in: STATUS }, presence: true

    after_initialize(on: :create) { self.status ||= 'open' }
  end

  def open?
    status == 'open'
  end

  def mark_as_open
    self.status = 'open'
  end

  def closed?
    status == 'closed'
  end

  def mark_as_closed
    self.status = 'closed'
  end
end
