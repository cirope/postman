module Tickets::Feedback
  extend ActiveSupport::Concern

  included do
    has_many :feedbacks, dependent: :destroy
  end

  def ask_for_feedback? to
    feedback_requested && feedbacks.find_by(from: to).blank?
  end
end
