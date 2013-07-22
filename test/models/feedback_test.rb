require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def setup
    @feedback = feedbacks(:positive)
  end

  test 'validates blank attributes' do
    @feedback.from = ''
    @feedback.score = ''
    
    assert @feedback.invalid?
    assert_error @feedback, :from, :blank
    assert_error @feedback, :score, :blank
  end

  test 'validates attributes inclusion' do
    @feedback.score = 'invalid'

    assert @feedback.invalid?
    assert_error @feedback, :score, :inclusion
  end
end
