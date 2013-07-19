require 'test_helper'

class ResponseMailerTest < ActionMailer::TestCase
  test 'reply' do
    ticket = tickets(:enhancement)
    tenant = ticket.tenant
    mail = ResponseMailer.reply ticket, ticket.body

    assert_equal ticket.subject_with_id, mail.subject
    assert_equal ticket.from, mail.to
    assert_equal [tenant.email], mail.from
    assert_match ticket.body, mail.body.encoded
  end
end
