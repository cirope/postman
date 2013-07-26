require 'test_helper'

class ResponseMailerHelperTest < ActionView::TestCase
  test 'reply history' do
    @ticket = Ticket.new

    assert_equal 0, reply_history.size

    @ticket = tickets(:enhancement)

    assert_operator reply_history.size, :>, 0
  end
end
