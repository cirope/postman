module ResponseMailerHelper
  def reply_history
    bodies = [@ticket.body] + @ticket.replies.map(&:body)

    bodies.reverse[1..-1]
  end
end
