module FeedbacksHelper
  def feedback_scores
    Feedback::SCORES
  end

  def feedback_score score
    t "feedbacks.scores.#{score}"
  end

  def create_feedback_path score
    ticket_feedbacks_path @ticket, feedback: { from: params[:from], score: score }
  end
end
