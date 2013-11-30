require 'test_helper'

class ResponseMailerTest < ActionMailer::TestCase
  test 'reply' do
    ticket = tickets(:enhancement)
    tenant = ticket.tenant
    mail = ResponseMailer.reply to: ticket.from.first, ticket: ticket, body: ticket.body

    assert_equal ticket.subject_with_id, mail.subject
    assert_equal ticket.from, mail.to
    assert_equal [tenant.email], mail.from
    assert_match ticket.body, mail.text_part.body.decoded
    assert_match ticket.body, mail.html_part.body.decoded
  end

  test 'reply with feedback' do
    ticket = tickets(:enhancement)
    tenant = ticket.tenant

    ticket.update_attributes! feedback_requested: true
    ticket.feedbacks.clear

    mail = ResponseMailer.reply to: ticket.from.first, ticket: ticket, body: ticket.body

    assert_equal ticket.subject_with_id, mail.subject
    assert_equal ticket.from, mail.to
    assert_equal [tenant.email], mail.from
    assert_equal 3, mail.attachments.size
  end
end
