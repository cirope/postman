require 'test_helper'

class FeedbacksControllerTest < ActionController::TestCase

  setup do
    @feedback = feedbacks :positive
    @ticket = @feedback.ticket
  end

  test 'should get index' do
    login

    get :index, ticket_id: @ticket
    assert_response :success
    assert_not_nil assigns(:feedbacks)
  end

  test 'should get new' do
    get :new, from: @ticket.from.first, ticket_id: @ticket
    assert_response :success
  end

  test 'should create feedback' do
    Feedback::SCORES.each do |score|
      assert_difference 'Feedback.count' do
        post :create, ticket_id: @ticket, feedback: {
          from: @feedback.from, score: score, notes: @feedback.notes
        }
      end

      assert_redirected_to edit_ticket_feedback_url(@ticket, assigns(:feedback))
      @ticket.feedbacks.clear
    end
  end

  test 'should show feedback' do
    login

    get :show, id: @feedback, ticket_id: @ticket
    assert_response :success
  end

  test 'should get edit' do
    Feedback::SCORES.each do |score|
      @feedback.update score: score

      get :edit, id: @feedback, ticket_id: @ticket
      assert_response :success
    end
  end

  test 'should update feedback' do
    patch :update, id: @feedback, ticket_id: @ticket, feedback: { notes: 'Some notes' }
    assert_redirected_to edit_ticket_feedback_url(@ticket, assigns(:feedback))
  end
end
