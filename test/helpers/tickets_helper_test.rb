require 'test_helper'

class TicketsHelperTest < ActionView::TestCase
  test 'categories' do
    assert_respond_to categories, :each
  end

  test 'status' do
    assert_respond_to status, :each
  end

  test 'ticket status' do
    ticket = tickets :enhancement

    assert_match /label-success/, ticket_status(ticket)

    ticket.status = 'closed'

    assert_match /label-error/, ticket_status(ticket)
  end
end
