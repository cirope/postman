require 'test_helper'

class TicketsControllerTest < ActionController::TestCase

  setup do
    @ticket = tickets(:enhancement)
    @tenant = @ticket.tenant

    login @ticket.user
  end

  test 'should get index for tenant' do
    get :index, tenant_id: @tenant
    assert_response :success
    assert_not_nil assigns(:tickets)
    assert assigns(:tickets).all? { |t| t.tenant_id == @tenant.id }
  end

  test 'should get index for current user' do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
    assert assigns(:tickets).all? { |t| t.user_id == @ticket.user_id }
  end

  test 'should get new' do
    get :new, tenant_id: @tenant
    assert_response :success
  end

  test 'should create ticket' do
    assert_difference 'ActionMailer::Base.deliveries.size', @ticket.from.size do
      assert_difference 'Ticket.count' do
        post :create, tenant_id: @tenant, ticket: {
          from_addresses: @ticket.from_addresses,
          subject: @ticket.subject,
          status: @ticket.status,
          category_id: @ticket.category_id,
          body: @ticket.body
        }
      end
    end

    assert_redirected_to ticket_url(assigns(:ticket))
  end

  test 'should show ticket' do
    get :show, id: @ticket, tenant_id: @tenant
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @ticket, tenant_id: @tenant
    assert_response :success
  end

  test 'should update ticket' do
    patch :update, tenant_id: @tenant, id: @ticket, ticket: { subject: 'new' }
    assert_redirected_to ticket_url(assigns(:ticket))
  end

  test 'should destroy ticket' do
    assert_difference('Ticket.count', -1) do
      delete :destroy, tenant_id: @tenant, id: @ticket
    end

    assert_redirected_to tenant_tickets_path(@tenant)
  end
end
