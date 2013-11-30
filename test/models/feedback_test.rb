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

  test 'validates unique attributes' do
    feedback = @feedback.dup

    assert feedback.invalid?
    assert_error feedback, :from, :taken
  end

  test 'first from' do
    assert_equal @feedback, Feedback.first_from(@feedback.from.upcase)
    assert_nil Feedback.first_from('no@way.com')
  end
end
