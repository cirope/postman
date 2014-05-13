require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages :enhancement_msg
  end

  test 'blank attributes' do
    @message.owner = nil

    assert @message.invalid?
    assert_error @message, :owner, :blank
  end
end
