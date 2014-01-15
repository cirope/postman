require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  def setup
    @reply = replies(:acknowledge)
  end

  test 'validates blank attributes' do
    @reply.body = ''

    assert @reply.invalid?
    assert_error @reply, :body, :blank
  end
end
