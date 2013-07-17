module Tickets::Validation
  extend ActiveSupport::Concern

  included do
    validates :subject, presence: true, length: { maximum: 255 }
    validate :must_have_one_from
  end

  private

  def must_have_one_from
    errors.add :from_addresses, :blank if from.empty?
  end
end
