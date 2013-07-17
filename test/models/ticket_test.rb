require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  def setup
    @ticket = tickets(:enhancement)
  end
    
  test 'validates blank attributes' do
    @ticket.from_addresses = ''
    @ticket.subject = ''
    
    assert @ticket.invalid?
    assert_error @ticket, :from_addresses, :blank
    assert_error @ticket, :subject, :blank
  end
    
  test 'validates attribute length' do
    @ticket.subject = 'abcde' * 52
    
    assert @ticket.invalid?
    assert_error @ticket, :subject, :too_long, count: 255
  end

  test 'from addresses' do
    @ticket.from_addresses = 'one@one.net, two@two.net, three@three.net'

    assert_equal %w(one@one.net two@two.net three@three.net), @ticket.from
    assert_equal 'one@one.net, two@two.net, three@three.net', @ticket.from_addresses
  end

  test 'receive new message' do
    assert_difference 'Ticket.count' do
      Ticket.receive_mail mail
    end
  end

  test 'receive message update' do
    mail = mail(with_id: true)

    assert_no_difference 'Ticket.count' do
      Ticket.receive_mail mail
    end

    assert_equal mail.body.decoded, @ticket.reload.body
  end

  private

  def mail with_id: false
    require 'mail' unless Object.const_defined? :Mail

    _headers = { 'X-Ticket-ID' => @ticket.id.to_s }

    Mail.new do
      headers _headers if with_id
      from    'nobody@test.net'
      to      'support@postman.com'
      subject 'Test email'
      body    "Some\nbody =)"
    end
  end
end
