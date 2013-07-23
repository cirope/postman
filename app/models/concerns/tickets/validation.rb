module Tickets::Validation
  extend ActiveSupport::Concern

  included do
    validates :subject, presence: true, length: { maximum: 255 }
    validate :must_have_one_from
    validate :must_have_valid_emails
  end

  private

  def must_have_one_from
    errors.add :from_addresses, :blank if from.empty?
  end

  def must_have_valid_emails
    unless from.all? { |address| address =~ EMAIL_REGEX }
      errors.add :from_addresses, :invalid
    end
  end
end
