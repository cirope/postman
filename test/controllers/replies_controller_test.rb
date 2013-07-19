require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  setup do
    @reply = replies(:acknowledge)
    @ticket = @reply.ticket

    login
  end

  test 'should get index' do
    get :index, ticket_id: @ticket
    assert_response :success
    assert_not_nil assigns(:replies)
  end

  test 'should get new' do
    get :new, ticket_id: @ticket
    assert_response :success
  end

  test 'should create reply' do
    assert_difference 'Reply.count' do
      post :create, ticket_id: @ticket, reply: { body: 'Test' }
    end

    assert_redirected_to ticket_reply_url(@ticket, assigns(:reply))
  end

  test 'should show reply' do
    get :show, ticket_id: @ticket, id: @reply
    assert_response :success
  end

  test 'should get edit' do
    get :edit, ticket_id: @ticket, id: @reply
    assert_response :success
  end

  test 'should update reply' do
    patch :update, ticket_id: @ticket, id: @reply, reply: { body: 'Updated' }
    assert_redirected_to ticket_reply_url(@ticket, assigns(:reply))
  end

  test 'should destroy reply' do
    assert_difference 'Reply.count', -1 do
      delete :destroy, ticket_id: @ticket, id: @reply
    end

    assert_redirected_to ticket_replies_path(@ticket)
  end
end
