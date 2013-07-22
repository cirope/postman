require 'test_helper'

class FeedbacksHelperTest < ActionView::TestCase
  test 'feedback scores' do
    assert_respond_to feedback_scores, :each
  end

  test 'feedback score' do
    Feedback::SCORES.each do |score|
      assert_no_match /missing/, feedback_score(score)
    end
  end

  test 'create feedback path' do
    @ticket = tickets :enhancement
    score = Feedback::SCORES.first

    assert_match /#{score}/, create_feedback_path(score)
  end
end
