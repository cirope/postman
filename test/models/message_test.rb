require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages :enhancement
  end

  test 'blank attributes' do
    @message.body = ''
    @message.owner = nil

    assert @message.invalid?
    assert_error @message, :body, :blank
    assert_error @message, :owner, :blank
  end
end
