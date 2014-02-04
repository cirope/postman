require 'test_helper'
require 'mail' unless Object.const_defined? :Mail

class TicketTest < ActiveSupport::TestCase
  def setup
    @ticket = tickets(:enhancement)
  end

  test 'validates blank attributes' do
    @ticket.from_addresses = ''
    @ticket.subject = ''
    @ticket.status = nil

    assert @ticket.invalid?
    assert_error @ticket, :from_addresses, :blank
    assert_error @ticket, :subject, :blank
    assert_error @ticket, :status, :blank
  end

  test 'validates attribute length' do
    @ticket.subject = 'abcde' * 52

    assert @ticket.invalid?
    assert_error @ticket, :subject, :too_long, count: 255
  end

  test 'validates included attributes' do
    @ticket.status = 'invalid'

    assert @ticket.invalid?
    assert_error @ticket, :status, :inclusion
  end

  test 'validates email attributes' do
    @ticket.from_addresses = 'valid@address.org, invalid@noway'

    assert @ticket.invalid?
    assert_error @ticket, :from_addresses, :invalid
  end

  test 'is from' do
    assert @ticket.is_from?(@ticket.from.first.upcase)
    assert !@ticket.is_from?('no@way.com')
  end

  test 'from addresses' do
    @ticket.from_addresses = 'one@one.net, two@two.net, three@three.net'

    assert_equal %w(one@one.net two@two.net three@three.net), @ticket.from
    assert_equal 'one@one.net, two@two.net, three@three.net', @ticket.from_addresses
  end

  test 'subject with id' do
    assert_no_match /\d+/, @ticket.subject
    assert_match /#\d+/, @ticket.subject_with_id

    @ticket.subject = @ticket.subject_with_id

    assert_equal 1, @ticket.subject_with_id.count('#')
  end

  test 'receive new message' do
    assert_difference 'Ticket.count' do
      Ticket.receive_mail mail
    end
  end

  test 'receive new multipart message' do
    assert_difference 'Ticket.count' do
      Ticket.receive_mail multipart_mail
    end
  end

  test 'receive message update' do
    mail = mail(with_id: true)

    assert @ticket.update status: 'closed'
    assert_not_nil @ticket.user

    assert_no_difference 'Ticket.count' do
      assert_difference '@ticket.replies.count' do
        Ticket.receive_mail mail
      end
    end

    assert @ticket.reload.open?
    assert_nil @ticket.user
  end

  test 'receive new cc message' do
    assert_difference 'Ticket.count' do
      Ticket.receive_mail mail(cc: true)
    end
  end

  test 'ask for feedback' do
    assert !@ticket.ask_for_feedback?(@ticket.from.first)

    @ticket.feedbacks.clear
    @ticket.feedback_requested = true

    assert @ticket.ask_for_feedback?(@ticket.from.first)
  end

  test 'loose or for' do
    user = users :franco
    loose = Ticket.create! @ticket.attributes.merge(id: nil, user_id: nil)
    ticket_ids = (user.tickets.to_a + [loose]).map(&:id).sort

    assert_equal ticket_ids, Ticket.loose_or_for(user).pluck('id').sort
  end

  test 'status methods' do
    @ticket.mark_as_closed
    assert @ticket.closed?

    @ticket.mark_as_open
    assert @ticket.open?
  end

  private

  def mail with_id: false, cc: false
    mail = create_mail with_id: with_id, cc: cc
    mail.body = "Some\nbody =)"

    mail
  end

  def multipart_mail with_id: false
    mail = create_mail with_id: with_id

    mail.text_part = Mail::Part.new do
      body 'Text body'
    end

    mail.html_part = Mail::Part.new do
      content_type 'text/html; charset=UTF-8'
      body '<h1>HTML body</h1>'
    end

    mail
  end

  def create_mail with_id: false, cc: false
    _subject =  "Test email"
    _subject << " [##{@ticket.id}]" if with_id

    Mail.new do
      from    'nobody@test.net'
      to      'support@postman.com' unless cc
      cc      'support@postman.com' if cc
      subject _subject
    end
  end
end
