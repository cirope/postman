module Tickets::Overrides
  extend ActiveSupport::Concern

  def to_s
    subject
  end
end
