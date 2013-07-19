module Tickets::Subject
  extend ActiveSupport::Concern

  def subject_with_id
    subject =~ /#\d+/ ? subject : "#{subject} [##{id}]"
  end
end
