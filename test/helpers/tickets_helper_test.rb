require 'test_helper'

class TicketsHelperTest < ActionView::TestCase
  test 'categories' do
    assert_respond_to categories, :each
  end

  test 'status' do
    assert_respond_to status, :each
  end

  test 'ticket status' do
    ticket = tickets :enhancement

    assert_match /label-success/, ticket_status(ticket)

    ticket.status = 'closed'

    assert_match /label-error/, ticket_status(ticket)
  end

  test 'ticket class' do
    ticket = tickets :enhancement

    assert_equal 'warning', ticket_class(ticket)

    ticket.status = 'closed'

    assert_equal 'active', ticket_class(ticket)

    ticket.user = nil

    assert_nil ticket_class(ticket)
  end

  test 'feedbacks label' do
    ticket = tickets :enhancement

    assert_match /#{t('navigation.show')}/, feedbacks_label(ticket)
  end

  test 'feedbacks count' do
    ticket = tickets :enhancement

    assert_match /#{ticket.feedbacks.count}/, feedbacks_count(ticket)
  end

  test 'tickets group by tenant' do
    @tenant = tenants :postman
    @tickets = @tenant.tickets

    assert_equal [[@tenant, @tickets]], tickets_group_by_tenant

    Tenant.all.each do |t|
      Ticket.create! tickets(:enhancement).attributes.merge(id: nil, tenant_id: t.id)
    end

    @tenant = nil
    @tickets = Ticket.all

    assert_operator Tenant.count, :>, 1
    assert_equal Tenant.ids.sort, tickets_group_by_tenant.map(&:first).map(&:id).sort
  end
end
